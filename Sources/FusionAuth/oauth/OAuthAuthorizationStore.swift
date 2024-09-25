import Foundation
import AppAuth

/// TODO
/// OAuthAuthorizationStore is a singleton object that stores the current OAuth authorization flow.
/// It provides methods to store, resume, cancel, and clear the current authorization flow.
public class OAuthAuthorizationStore {
    static let shared = OAuthAuthorizationStore()

    private(set) var currentAuthorizationFlow: OIDExternalUserAgentSession?

    func resume(_ url: URL) -> Bool {
        if let flow = self.currentAuthorizationFlow, flow.resumeExternalUserAgentFlow(with: url) {
            self.currentAuthorizationFlow = nil
            return true
        }
        return false
    }

    func store(_ flow: OIDExternalUserAgentSession) {
        self.currentAuthorizationFlow = flow
    }

    func cancel() {
        self.currentAuthorizationFlow?.cancel()
        self.currentAuthorizationFlow = nil
    }

    func clear() {
        self.currentAuthorizationFlow = nil
    }

}
