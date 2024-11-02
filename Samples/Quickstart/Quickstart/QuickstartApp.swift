import SwiftUI
import FusionAuth

@main
struct QuickstartApp: App {
    let fusionAuthState = FusionAuthStateObject()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(fusionAuthState)
                .onOpenURL { url in
                    OAuthAuthorization.resume(with: url)
                }
        }
    }
}
