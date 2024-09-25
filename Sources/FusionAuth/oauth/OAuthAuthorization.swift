import Foundation

/// TODO
/// OAuthAuthorization is a utility struct that provides methods to resume and cancel the OAuth authorization flow.
public struct OAuthAuthorization {

    private init() {}

    /// Resume the authorization flow with the URL
    /// - Parameter url: The URL to resume the authorization flow
    /// - Returns: A boolean value indicating if the authorization flow was resumed
    /// - Note: This method resumes the authorization flow with the given URL and returns true if the flow was resumed successfully.
    @discardableResult
    public static func resume(with url: URL) -> Bool {
        return OAuthAuthorizationStore.shared.resume(url)
    }

    /// Cancel the authorization flow
    /// - Returns: Void
    public static func cancel() {
        OAuthAuthorizationStore.shared.cancel()
    }

}
