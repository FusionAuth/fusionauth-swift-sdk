import Foundation
import AppAuth
import UIKit
import SwiftUI

enum OAuthError: Error {
    case oIDConfigurationNil
    case authStateNil
    case noAuthorizationCode
    case accessTokenNil
    case userInfoEndpointNotFound
    case userInfoInvalid
}

/// OAuthAuthorizationService class is responsible for handling OAuth authorization and authorization process.
/// It provides methods to authorize the user, handle the redirect intent, fetch user information,
/// perform logout, retrieve fresh access token, and get the authorization service.
public class OAuthAuthorizationService {
    private static var appAuthState: OIDAuthState?

    private let fusionAuthUrl: String
    private let clientId: String
    private let tenantId: String?
    private let locale: String?
    private let additionalScopes: [String]

    private var configurationTask: Task<OIDServiceConfiguration, Error>?

    private var tokenTask: Task<String, Error>?

    init(fusionAuthUrl: String, clientId: String, tenantId: String?, locale: String?, additionalScopes: [String]) {
        self.fusionAuthUrl = fusionAuthUrl
        self.clientId = clientId
        self.tenantId = tenantId
        self.locale = locale
        self.additionalScopes = additionalScopes
    }

    @MainActor
    public func authorize(options: OAuthAuthorizeOptions, view: UIViewController) async throws -> OIDAuthState {
        let configuration = try await getConfiguration()

        let request = OIDAuthorizationRequest(configuration: configuration,
                                              clientId: clientId,
                                              scopes: [OIDScopeOpenID, "offline_access"] + self.additionalScopes,
                                              redirectURL: URL(string: options.redirectUri)!,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: getParametersFromOptions(options))

        let authState: OIDAuthState = try await withCheckedThrowingContinuation { continuation in
            OAuthAuthorizationStore.shared.store(OIDAuthState.authState(byPresenting: request, presenting: view) { authState, error in
                if error != nil {
                    continuation.resume(throwing: error!)
                    return
                }

                guard let authorizationState = authState else {
                    continuation.resume(throwing: OAuthError.authStateNil)
                    return
                }

                continuation.resume(returning: authorizationState)
            })
        }

        OAuthAuthorizationStore.shared.clear()

        OAuthAuthorizationService.appAuthState = authState

        AuthorizationManager.fusionAuthState.update(authState: authState)

        return authState
    }

    public func userInfo() async throws -> UserInfo {
        let configuration = try await getConfiguration()

        guard let userinfoEndpoint = configuration.discoveryDocument?.userinfoEndpoint else {
            throw OAuthError.userInfoEndpointNotFound
        }

        return try await withCheckedThrowingContinuation { continuation in
            guard let authState = OAuthAuthorizationService.appAuthState else {
                continuation.resume(throwing: OAuthError.accessTokenNil)
                return
            }

            authState.performAction { (accessToken, _, error) in
                if error != nil {
                    continuation.resume(throwing: error!)
                    return
                }

                guard accessToken != nil else {
                    continuation.resume(throwing: OAuthError.accessTokenNil)
                    return
                }

                var request = URLRequest(url: userinfoEndpoint)
                request.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken!)"]

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    }
                    guard error == nil else {
                        continuation.resume(throwing: error!)
                        return
                    }
                    guard let response = response as? HTTPURLResponse else {
                        continuation.resume(throwing: OAuthError.noAuthorizationCode)
                        return
                    }
                    guard let data = data else {
                        print("HTTP response data is empty")
                        return
                    }

                    if response.statusCode != 200 {
                        let responseText: String? = String(data: data, encoding: String.Encoding.utf8)
                        print("HTTP: \(response.statusCode), Response: \(String(data: data, encoding: String.Encoding.utf8) ?? "RESPONSE_TEXT")")

                        continuation.resume(throwing: OAuthError.accessTokenNil)
                        return
                    }

                    do {
                        let userInfo = try JSONDecoder().decode(UserInfo.self, from: data)
                        continuation.resume(returning: userInfo)
                    } catch let jsonError as NSError {
                        print(jsonError)
                        continuation.resume(throwing: jsonError)
                    }
                }.resume()
            }
        }
    }

    private func getConfiguration(force: Bool = false) async throws -> OIDServiceConfiguration {
        if !force {
            if let configurationTask {
                return try await configurationTask.value
            }
        }

        let task = Task {
            return try await fetchConfiguration()
        }
        self.configurationTask = task

        return try await withTaskCancellationHandler {
            try await task.value
        } onCancel: {
            task.cancel()
        }
    }

    private func fetchConfiguration() async throws -> OIDServiceConfiguration {
        try await withCheckedThrowingContinuation { continuation in
            let issuer = URL(string: self.fusionAuthUrl)
            OIDAuthorizationService.discoverConfiguration(forIssuer: issuer!) { configuration, error in
                if error != nil {
                    continuation.resume(throwing: error!)
                    return
                }

                guard let config = configuration else {
                    continuation.resume(throwing: OAuthError.oIDConfigurationNil)
                    return
                }

                continuation.resume(returning: config)
            }
        }
    }

    /// Builds additional parameters for the OAuth authorize request.
    private func getParametersFromOptions(_ options: OAuthAuthorizeOptions) -> [String: String] {
        var additionalParameters: [String: String] = [:]
        if tenantId != nil {
            additionalParameters.updateValue(tenantId!, forKey: "tenantId")
        }
        if locale != nil {
            additionalParameters.updateValue(locale!, forKey: "locale")
        }
        if options.codeChallenge != nil {
            additionalParameters.updateValue(options.codeChallenge!, forKey: "code_challenge")
        }
        if options.codeChallengeMethod != nil {
            additionalParameters.updateValue(options.codeChallengeMethod!.rawValue, forKey: "code_challenge_method")
        }
        if options.idpHint != nil {
            additionalParameters.updateValue(options.idpHint!, forKey: "idp_hint")
        }
        if options.deviceDescription != nil {
            additionalParameters.updateValue(options.deviceDescription!, forKey: "metaData.device.description")
        }
        if options.userCode != nil {
            additionalParameters.updateValue(options.userCode!, forKey: "user_code")
        }

        return additionalParameters
    }

}
