import Foundation
@preconcurrency import AppAuthTV

/// OAuthDeviceAuthorizationData describes the information returned by the device authorization endpoint.
public struct OAuthDeviceAuthorizationData {
    /// The end-user verification URL.
    public let verificationURI: String?
    /// A complete verification URL that may include the user code.
    public let verificationURIComplete: String?
    /// The user code to display to the user.
    public let userCode: String?
    /// Polling interval in seconds.
    public let interval: TimeInterval?
    /// The expiration date for the device authorization request.
    public let expirationDate: Date?

    internal init(response: OIDTVAuthorizationResponse) {
        self.verificationURI = response.verificationURI
        self.verificationURIComplete = response.verificationURIComplete
        self.userCode = response.userCode
        self.interval = response.interval?.doubleValue
        self.expirationDate = response.expirationDate
    }
}
