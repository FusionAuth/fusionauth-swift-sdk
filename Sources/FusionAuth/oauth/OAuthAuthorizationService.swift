import Foundation
import AppAuth
import SwiftUI
import AuthenticationServices

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

enum OAuthError: Error {
    case oIDConfigurationNil
    case authStateNil
    case noAuthorizationCode
    case accessTokenNil
    case userInfoEndpointNotFound
    case userInfoInvalid
    case refreshTokenNil
    case refreshTokenNoResponse
    case unableToUpdateInternalState
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

    private var logoutSession: OIDExternalUserAgentSession?

    init(fusionAuthUrl: String, clientId: String, tenantId: String?, locale: String?, additionalScopes: [String]) {
        self.fusionAuthUrl = fusionAuthUrl
        self.clientId = clientId
        self.tenantId = tenantId
        self.locale = locale
        self.additionalScopes = additionalScopes
    }

    #if os(macOS)
    private func getPresenting() -> NSWindow {
        return ASPresentationAnchor()
    }
    #else
    private func getPresenting() -> UIViewController {
        return UIApplication.shared.topViewController!
    }
    #endif

    @discardableResult
    public func authorize(options: OAuthAuthorizeOptions) async throws -> OIDAuthState {
        AuthorizationManager.log?.trace("Starting OAuth authorization...")

        let configuration = try await getConfiguration()

        let request = OIDAuthorizationRequest(configuration: configuration,
                                              clientId: clientId,
                                              scopes: [OIDScopeOpenID, "offline_access"] + self.additionalScopes,
                                              redirectURL: URL(string: options.redirectUri)!,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: getParametersFromOptions(options))

        let authState: OIDAuthState = try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                OAuthAuthorizationStore.shared.store(OIDAuthState.authState(byPresenting: request, presenting: self.getPresenting()) { authState, error in
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
        }

        OAuthAuthorizationStore.shared.clear()

        OAuthAuthorizationService.appAuthState = authState

        DispatchQueue.main.async {
            do {
                try AuthorizationManager.instance.updateAuthState(authState: authState)
            } catch {
                AuthorizationManager.log?.warning("Unable to update internal state after authorize")
            }
        }

        AuthorizationManager.log?.trace("Finishing OAuth authorization...")

        return authState
    }

    public func userInfo() async throws -> UserInfo {
        let configuration = try await getConfiguration()

        guard let userinfoEndpoint = configuration.discoveryDocument?.userinfoEndpoint else {
            throw OAuthError.userInfoEndpointNotFound
        }

        guard let accessToken = try await freshAccessToken() else {
            throw OAuthError.accessTokenNil
        }

        return try await getUserInfo(userinfoEndpoint: userinfoEndpoint, accessToken: accessToken)
    }

    public func logout(options: OAuthLogoutOptions) async throws {
        let idToken = OAuthAuthorizationService.appAuthState?.lastTokenResponse?.idToken

        guard let idToken = idToken else {
            throw OAuthError.accessTokenNil
        }

        let configuration = try await getConfiguration()

        #if os(macOS)
        let userAgent = OIDExternalUserAgentMac(presenting: getPresenting())
        #else
        guard let userAgent = OIDExternalUserAgentIOS(presenting: getPresenting()) else {
            return
        }
        #endif

        let request: OIDEndSessionRequest

        if options.state == nil || options.state!.isEmpty {
            request = OIDEndSessionRequest(configuration: configuration,
                                           idTokenHint: idToken,
                                           postLogoutRedirectURL: URL(string: options.postLogoutRedirectUri)!,
                                           additionalParameters: nil)
        } else {
            request = OIDEndSessionRequest(configuration: configuration,
                                           idTokenHint: idToken,
                                           postLogoutRedirectURL: URL(string: options.postLogoutRedirectUri)!,
                                           state: options.state!,
                                           additionalParameters: nil)
        }

        let _: Bool = try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                self.logoutSession = OIDAuthorizationService.present(request, externalUserAgent: userAgent) { _, error in
                    if error != nil {
                        continuation.resume(throwing: error!)
                        return
                    }

                    continuation.resume(returning: true)
                }
            }
        }

        self.logoutSession = nil
        OAuthAuthorizationService.appAuthState = nil

        DispatchQueue.main.async {
            do {
                try AuthorizationManager.instance.clearState()
            } catch {
                AuthorizationManager.log?.warning("Unable to clear internal state after logout")
            }
        }
    }

    public func freshAccessToken() async throws -> String? {
        AuthorizationManager.log?.trace("Retrieve fresh token from FusionAuth")

        if let tokenTask {
            return try await tokenTask.value
        }

        let task = Task {
            return try await freshAccessTokenInternal()
        }
        self.tokenTask = task

        return try await withTaskCancellationHandler {
            try await task.value
        } onCancel: {
            task.cancel()
        }
    }

    private func freshAccessTokenInternal() async throws -> String {
        let configuration = try await getConfiguration()

        return try await withCheckedThrowingContinuation { continuation in
            guard let refreshToken = AuthorizationManager.instance.getTokenManager().getAuthState()?.refreshToken else {
                continuation.resume(throwing: OAuthError.refreshTokenNil)
                return
            }

            let request = OIDTokenRequest(configuration: configuration, grantType: OIDGrantTypeRefreshToken, authorizationCode: nil, redirectURL: nil, clientID: clientId, clientSecret: nil, scope: nil, refreshToken: refreshToken, codeVerifier: nil, additionalParameters: nil)

            DispatchQueue.main.async {
                OIDAuthorizationService.perform(request) { response, error in
                    if error != nil {
                        continuation.resume(throwing: error!)
                        return
                    }

                    guard let response = response else {
                        continuation.resume(throwing: OAuthError.refreshTokenNoResponse)
                        return
                    }

                    guard let accessToken = response.accessToken else {
                        continuation.resume(throwing: OAuthError.accessTokenNil)
                        return
                    }

                    do {
                        try AuthorizationManager.instance.updateAuthState(
                            accessToken: accessToken,
                            accessTokenExpirationTime: response.accessTokenExpirationDate!,
                            idToken: response.idToken!,
                            refreshToken: response.refreshToken!
                        )
                    } catch {
                        continuation.resume(throwing: OAuthError.unableToUpdateInternalState)
                    }

                    continuation.resume(returning: response.accessToken!)
                }
            }
        }
    }

    private func getUserInfo(userinfoEndpoint: URL, accessToken: String) async throws -> UserInfo {
        try await withCheckedThrowingContinuation { continuation in
            var request = URLRequest(url: userinfoEndpoint)
            request.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken)"]

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
                    print("HTTP: \(response.statusCode), Response: \(String(decoding: data, as: UTF8.self))")

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

    private func getConfiguration(force: Bool = false) async throws -> OIDServiceConfiguration {
        AuthorizationManager.log?.trace("Retrieving configuration from FusionAuth")

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
