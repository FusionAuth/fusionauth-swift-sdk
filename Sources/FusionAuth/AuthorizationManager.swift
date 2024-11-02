import os
import AppAuth
import Combine

/// AuthorizationManager is a singleton object that manages the authorization state of the user.
/// It provides methods to initialize the authorization manager, check if the user is authenticated,
/// retrieve access tokens, refresh access tokens, and clear the authorization state.
///
/// AuthorizationManager uses a TokenManager to manage the access tokens and a Storage implementation
/// to store the authorization state.
public class AuthorizationManager {
    /// The shared instance of the AuthorizationManager
    public static let instance = AuthorizationManager()

    private var configuration: AuthorizationConfiguration?
    private var tokenManager: TokenManager?

    private init() {}

    /// Initialize the AuthorizationManager with the given configuration
    public func initialize(configuration: AuthorizationConfiguration, storage: Storage? = nil) {
        self.configuration = configuration
        self.tokenManager = TokenManager().withStorage(storage: storage ?? MemoryStorage())

        if let authState = tokenManager?.getAuthState() {
            triggerEvent(authState)
        }
    }

    /// Returns the current TokenManager
    public func getTokenManager() -> TokenManager {
        return tokenManager!
    }

    /// Returns an instance of the OAuthAuthorizationService, configured with the current configuration
    public func oauth() -> OAuthAuthorizationService {
        return OAuthAuthorizationService(
            fusionAuthUrl: configuration!.fusionAuthUrl,
            clientId: configuration!.clientId,
            tenantId: configuration!.tenant,
            locale: configuration!.locale,
            additionalScopes: configuration!.additionalScopes
        )
    }

    /// Returns a fresh access token
    ///
    /// If the access token is not expired, it will be returned immediately.
    /// If the access token is expired or force is `true`, a new access token will be fetched using the refresh token.
    public func freshAccessToken(force: Bool = false) async throws -> String? {
        if !force && !self.isAccessTokenExpired() {
            return self.getAccessToken()
        }

        // We always use oAuth to get a fresh access token
        return try await oauth().freshAccessToken()
    }

    /// Retrieves the access token, if available
    public func getAccessToken() -> String? {
        return self.tokenManager?.getAuthState()?.accessToken
    }

    /// Retrieves the access token expiration, if available
    public func getAccessTokenExpirationTime() -> Date? {
        return self.tokenManager?.getAuthState()?.accessTokenExpirationTime
    }

    /// Checks if the stored access token is expired.
    public func isAccessTokenExpired() -> Bool {
        guard let expiration = self.getAccessTokenExpirationTime() else {
            return true
        }

        return expiration.timeIntervalSinceNow.sign == .minus
    }

    internal func updateAuthState(authState: OIDAuthState) throws {
        try updateAuthState(fusionAuthState: FusionAuthState(
            accessToken: authState.lastTokenResponse?.accessToken ?? "",
            accessTokenExpirationTime: authState.lastTokenResponse?.accessTokenExpirationDate ?? Date(),
            idToken: authState.lastTokenResponse?.idToken ?? "",
            refreshToken: authState.refreshToken ?? ""
        ))
    }

    internal func updateAuthState(accessToken: String, accessTokenExpirationTime: Date, idToken: String, refreshToken: String) throws {
        try updateAuthState(fusionAuthState: FusionAuthState(
            accessToken: accessToken,
            accessTokenExpirationTime: accessTokenExpirationTime,
            idToken: idToken,
            refreshToken: refreshToken
        ))
    }

    private func updateAuthState(fusionAuthState: FusionAuthState) throws {
        try self.tokenManager?.saveAuthState(fusionAuthState)
        triggerEvent(fusionAuthState)
    }

    internal func clearState() throws {
        try self.tokenManager?.clearAuthState()
        triggerEvent(nil)
    }

    private let eventSubject = PassthroughSubject<FusionAuthState?, Never>()

    /// A publisher that emits the current FusionAuthState whenever it changes
    public var eventPublisher: AnyPublisher<FusionAuthState?, Never> {
        eventSubject.eraseToAnyPublisher()
    }

    internal func triggerEvent(_ event: FusionAuthState?) {
        eventSubject.send(event)
    }
}

// MARK: - Logger
extension AuthorizationManager {
    /// The logger for the FusionAuth Mobile SDK
    public static var log: Logger?

    /// Set the log level for the AuthorizationManager
    public static func setLogLevel(_ level: OSLogType) {
        self.log = Logger(subsystem: "io.fusionauth.mobilesdk", category: "AuthorizationManager")
    }
}
