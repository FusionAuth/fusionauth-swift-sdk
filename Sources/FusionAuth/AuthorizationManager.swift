import os

/// AuthorizationManager is a singleton object that manages the authorization state of the user.
/// It provides methods to initialize the authorization manager, check if the user is authenticated,
/// retrieve access tokens, refresh access tokens, and clear the authorization state.
///
/// AuthorizationManager uses a TokenManager to manage the access tokens and a Storage implementation
/// to store the authorization state.
public class AuthorizationManager {

    public static let fusionAuthState = FusionAuthState()

    public static let instance = AuthorizationManager()

    private var configuration: AuthorizationConfiguration?

    private init() {}

    public func initialize(configuration: AuthorizationConfiguration, storage: String?) {
        self.configuration = configuration
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

}

extension AuthorizationManager {

    public static var log: Logger?

    public static func setLogLevel(_ level: OSLogType) {
        self.log = Logger(subsystem: "io.fusionauth.mobilesdk", category: "AuthorizationManager")
    }

}
