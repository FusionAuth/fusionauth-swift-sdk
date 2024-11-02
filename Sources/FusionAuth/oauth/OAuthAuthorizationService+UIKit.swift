#if canImport(AppKit)
import AppKit

extension OAuthAuthorizationService {
    func getPresenting() -> NSWindow {
        return ASPresentationAnchor()
    }
}
#endif
