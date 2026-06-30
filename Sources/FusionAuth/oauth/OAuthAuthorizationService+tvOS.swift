#if os(tvOS)
import Foundation
@preconcurrency import AppAuth
@preconcurrency import AppAuthTV

extension OAuthAuthorizationService {

    // MARK: - TV Configuration

    /// Retrieves the OIDTVServiceConfiguration from FusionAuth, which includes the device authorization endpoint.
    private func getTVConfiguration() async throws -> OIDTVServiceConfiguration {
        AuthorizationManager.log?.trace("Retrieving TV service configuration from FusionAuth")

        return try await withCheckedThrowingContinuation { continuation in
            guard let baseURL = URL(string: self.fusionAuthUrl) else {
                continuation.resume(throwing: OAuthError.invalidIssuer)
                return
            }

            let issuer: URL
            if let tenantId = self.tenantId {
                issuer = baseURL.appendingPathComponent(tenantId)
            } else {
                issuer = baseURL
            }

            OIDTVAuthorizationService.discoverServiceConfiguration(forIssuer: issuer) { configuration, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let tvConfig = configuration else {
                    continuation.resume(throwing: OAuthError.deviceAuthorizationEndpointNotFound)
                    return
                }

                continuation.resume(returning: tvConfig)
            }
        }
    }

    // MARK: - Authorization (tvOS Device Authorization Grant)

    /// Authorizes the user using the OAuth 2.0 Device Authorization Grant (RFC 8628).
    ///
    /// This method initiates the device authorization flow, which is the standard OAuth flow for
    /// tvOS and other limited-input devices. The user must complete authorization on a secondary
    /// device (e.g., a phone or computer) by visiting the verification URI and entering the user code.
    ///
    /// - Parameter options: The options to configure the OAuth authorize request. On tvOS,
    ///   the `deviceAuthorizationCallback` is called with the user code and verification URI
    ///   that must be displayed to the user.
    /// - Returns: The OAuth authorization state.
    @discardableResult
    public func authorize(options: OAuthAuthorizeOptions) async throws -> OIDAuthState {
        AuthorizationManager.log?.trace("Starting tvOS device authorization flow...")

        let tvConfig = try await getTVConfiguration()

        let request = OIDTVAuthorizationRequest(
            configuration: tvConfig,
            clientId: clientId,
            clientSecret: nil,
            scopes: [OIDScopeOpenID, "offline_access"] + self.additionalScopes,
            additionalParameters: getParametersFromOptions(options)
        )

        let authState: OIDAuthState = try await withCheckedThrowingContinuation { continuation in
            var didResume = false

            OIDTVAuthorizationService.authorizeTVRequest(
                request,
                initialization: { response, error in
                    if let error {
                        guard !didResume else { return }
                        didResume = true
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let response,
                          let userCode = response.userCode,
                          let verificationURIString = response.verificationURI,
                          let verificationURI = URL(string: verificationURIString) else {
                        guard !didResume else { return }
                        didResume = true
                        continuation.resume(throwing: OAuthError.tvOSDeviceAuthNil)
                        return
                    }

                    // Surface the user code and verification URI to the app so it can display them
                    DispatchQueue.main.async {
                        options.deviceAuthorizationCallback?(userCode, verificationURI)
                    }
                },
                completion: { authState, error in
                    guard !didResume else { return }
                    didResume = true

                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let authState else {
                        continuation.resume(throwing: OAuthError.authStateNil)
                        return
                    }

                    continuation.resume(returning: authState)
                }
            )
        }

        DispatchQueue.main.async {
            do {
                try AuthorizationManager.instance.updateAuthState(authState: authState)
            } catch {
                AuthorizationManager.log?.warning("Unable to update internal state after authorize")
            }
        }

        AuthorizationManager.log?.trace("Finishing tvOS device authorization flow...")

        return authState
    }

    // MARK: - Logout (tvOS)

    /// Log out the user by clearing the local authorization state.
    ///
    /// On tvOS, the standard browser-based end-session flow is not available.
    /// This method clears the locally stored tokens. The server-side session will
    /// expire naturally according to the FusionAuth configuration.
    ///
    /// - Parameter options: The options for the logout request (unused on tvOS).
    public func logout(options: OAuthLogoutOptions) async throws {
        AuthorizationManager.log?.trace("Clearing tvOS authorization state...")

        DispatchQueue.main.async {
            do {
                try AuthorizationManager.instance.clearState()
            } catch {
                AuthorizationManager.log?.warning("Unable to clear internal state after logout")
            }
        }
    }
}
#endif
