/// AuthorizationConfiguration is a struct that represents the configuration for authorization.
public struct AuthorizationConfiguration {
    /// The client ID used for authorization.
    let clientId: String
    /// The URL of the FusionAuth server.
    let fusionAuthUrl: String
    /// The tenant ID for the FusionAuth server. (Optional)
    let tenant: String?
    /// Additional scopes to be requested during authorization. Default is empty.
    let additionalScopes: [String]
    /// The locale to be used for authorization. (Optional)
    let locale: String?

    public init(clientId: String, fusionAuthUrl: String, tenant: String? = nil, additionalScopes: [String] = [], locale: String? = nil) {
        self.clientId = clientId
        self.fusionAuthUrl = fusionAuthUrl
        self.tenant = tenant
        self.additionalScopes = additionalScopes
        self.locale = locale
    }
}
