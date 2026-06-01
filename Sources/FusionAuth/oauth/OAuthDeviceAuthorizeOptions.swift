import Foundation

/// OAuthDeviceAuthorizeOptions is a data class that represents the options for the OAuth device authorization request.
///
/// See [FusionAuth OAuth 2.0 Device Authorization Endpoint](https://fusionauth.io/docs/apis/identity-providers/oauth2#start-the-device-authorization-grant)
/// for more information.
public struct OAuthDeviceAuthorizeOptions {
    /// The client secret. Optional for public clients.
    let clientSecret: String?
    /// The identity provider hint to be used for the OAuth device authorization request.
    let idpHint: String?
    /// An optional email address or top level domain that can allow you to bypass the FusionAuth login
    /// page when using managed domains.
    let loginHint: String?
    /// An optional human-readable description of the device used during login.
    let deviceDescription: String?
    /// Additional parameters for the device authorization request.
    let additionalParameters: [String: String]
    /// Scopes to request. If omitted, defaults to openid + offline_access + configured additional scopes.
    let scopes: [String]?

    /// Creates a new instance of OAuthDeviceAuthorizeOptions.
    public init(
        clientSecret: String? = nil,
        idpHint: String? = nil,
        loginHint: String? = nil,
        deviceDescription: String? = nil,
        additionalParameters: [String: String] = [:],
        scopes: [String]? = nil
    ) {
        self.clientSecret = clientSecret
        self.idpHint = idpHint
        self.loginHint = loginHint
        self.deviceDescription = deviceDescription
        self.additionalParameters = additionalParameters
        self.scopes = scopes
    }
}
