#if canImport(UIKit)
import UIKit

extension OAuthAuthorizationService {
    func getPresenting() -> UIViewController {
        return UIApplication.topViewController!
    }
}
#endif
