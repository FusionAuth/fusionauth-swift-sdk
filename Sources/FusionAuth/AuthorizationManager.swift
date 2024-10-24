import os
import AppAuth

/// AuthorizationManager is a singleton object that manages the authorization state of the user.
/// It provides methods to initialize the authorization manager, check if the user is authenticated,
/// retrieve access tokens, refresh access tokens, and clear the authorization state.
///
/// AuthorizationManager uses a TokenManager to manage the access tokens and a Storage implementation
/// to store the authorization state.
public class AuthorizationManager {

    private static let fusionAuthState = FusionAuthState()

    public static let instance = AuthorizationManager()

    private var configuration: AuthorizationConfiguration?
    private var tokenManager: TokenManager?

    private init() {}

    public func initialize(configuration: AuthorizationConfiguration, storage: Storage? = nil) {
        self.configuration = configuration
        self.tokenManager = TokenManager().withStorage(storage: storage ?? MemoryStorage())

        if let authState = tokenManager?.getAuthState() {
            AuthorizationManager.instance.fusionAuthState().update(authState: authState)
        }
    }

    public func fusionAuthState() -> FusionAuthState {
        return AuthorizationManager.fusionAuthState
    }

    public func getTokenManager() -> TokenManager {
        return tokenManager!
    }

    public func oauth() -> OAuthAuthorizationService {
        return OAuthAuthorizationService(
            fusionAuthUrl: configuration!.fusionAuthUrl,
            clientId: configuration!.clientId,
            tenantId: configuration!.tenant,
            locale: configuration!.locale,
            additionalScopes: configuration!.additionalScopes
        )
    }

    public func freshAccessToken(force: Bool = false) async throws -> String? {
        if !force && !self.isAccessTokenExpired() {
            return self.getAccessToken()
        }

        return try await oauth().freshAccessToken()
    }

    public func getAccessToken() -> String? {
        return self.tokenManager?.getAuthState()?.accessToken
    }

    public func getAccessTokenExpirationTime() -> Date? {
        return self.tokenManager?.getAuthState()?.accessTokenExpirationTime
    }

    public func isAccessTokenExpired() -> Bool {
        guard let expiration = self.getAccessTokenExpirationTime() else {
            return true
        }

        return expiration.timeIntervalSinceNow.sign == .minus
    }

    public func updateAuthState(authState: OIDAuthState) throws {
        try updateAuthState(fusionAuthStateData: FusionAuthStateData(
            accessToken: authState.lastTokenResponse?.accessToken ?? "",
            accessTokenExpirationTime: authState.lastTokenResponse?.accessTokenExpirationDate ?? Date(),
            idToken: authState.lastTokenResponse?.idToken ?? "",
            refreshToken: authState.refreshToken ?? ""
        ))
    }

    public func updateAuthState(accessToken: String, accessTokenExpirationTime: Date, idToken: String, refreshToken: String) throws {
        try updateAuthState(fusionAuthStateData: FusionAuthStateData(
            accessToken: accessToken,
            accessTokenExpirationTime: accessTokenExpirationTime,
            idToken: idToken,
            refreshToken: refreshToken
        ))
    }

    private func updateAuthState(fusionAuthStateData: FusionAuthStateData) throws {
        try self.tokenManager?.saveAuthState(fusionAuthStateData)
        AuthorizationManager.instance.fusionAuthState().update(authState: fusionAuthStateData)
    }

    public func clearState() throws {
        try self.tokenManager?.clearAuthState()
        AuthorizationManager.instance.fusionAuthState().clear()
    }

}

extension AuthorizationManager {

    public static var log: Logger?

    public static func setLogLevel(_ level: OSLogType) {
        self.log = Logger(subsystem: "io.fusionauth.mobilesdk", category: "AuthorizationManager")
    }

}
