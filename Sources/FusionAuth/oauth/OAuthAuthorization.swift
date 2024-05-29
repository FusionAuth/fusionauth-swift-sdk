import Foundation

public struct OAuthAuthorization {

    private init() {}

    public static func resume(with url: URL) -> Bool {
        print("resuuming")
        return OAuthAuthorizationStore.shared.resume(url)
    }

    public static func cancel() {
        OAuthAuthorizationStore.shared.cancel()
    }

}
