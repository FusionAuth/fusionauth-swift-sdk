import Foundation
import AppAuth

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
