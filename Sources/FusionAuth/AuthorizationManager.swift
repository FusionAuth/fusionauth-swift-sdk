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

    public func initialize(configuration: AuthorizationConfiguration, storage: Storage?) {
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

    public func updateAuthState(authState: OIDAuthState) {
        self.tokenManager?.setAuthState(authState: authState)
        AuthorizationManager.instance.fusionAuthState().update(authState: authState)
    }

}

extension AuthorizationManager {

    public static var log: Logger?

    public static func setLogLevel(_ level: OSLogType) {
        self.log = Logger(subsystem: "io.fusionauth.mobilesdk", category: "AuthorizationManager")
    }

}
