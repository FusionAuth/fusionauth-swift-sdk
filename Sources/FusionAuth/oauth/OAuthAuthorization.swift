import Foundation

/// TODO
/// OAuthAuthorization is a utility struct that provides methods to resume and cancel the OAuth authorization flow.
public struct OAuthAuthorization {

    private init() {}

    @discardableResult
    public static func resume(with url: URL) -> Bool {
        return OAuthAuthorizationStore.shared.resume(url)
    }

    public static func cancel() {
        OAuthAuthorizationStore.shared.cancel()
    }

}
