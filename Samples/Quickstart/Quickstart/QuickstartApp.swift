import SwiftUI
import FusionAuth
import LocalAuthentication

@main
struct QuickstartApp: App {
    let fusionAuthState = FusionAuthStateObject()
    @Environment(\.scenePhase) private var scenePhase
    private let biometricStorage = BiometricStorage()
    
    /// Clears all persisted credentials and forces a fresh login.
    private func forceLogout() {
        // Lock and clear any biometric-protected storage.
        AuthorizationManager.instance.lockBiometrics()
        do {
            try AuthorizationManager.instance.clearAllState()
        } catch {
            // If the SDK does not provide clearCredentials or it throws, attempt best-effort cleanup.
            // Ignored on purpose; we'll still reset app state.
            print("Failed to clear credentials explicitly: \(error)")
        }
    }

    init() {
        // Configure AuthorizationManager to use biometric-protected storage.
        // If you already have a configuration object, use it here; otherwise the default will be used.
        AuthorizationManager.instance.initialize(storage: biometricStorage)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(fusionAuthState)
                .onOpenURL { url in
                    OAuthAuthorization.resume(with: url)
                }
                .task {
                    // Attempt to unlock biometric storage on launch/activation with a user prompt.
                    do {
                        try await AuthorizationManager.instance.enableBiometrics(reason: "Unlock your account")
                        print("Biometrics enabled/unlocked without prompt - task")
                    } catch BiometricStorageError.biometricsNotAvailable {
                        // Biometrics unavailable. Authorization will fall back to memory-only tokens.
                        print("Biometrics not unavailable - task")
                        forceLogout()
                    } catch BiometricStorageError.authenticationFailed {
                        // User canceled or failed authentication; storage remains locked.
                        print("Authentication Failed - task")
                        forceLogout()
                    } catch {
                        // Handle other unexpected errors.
                        forceLogout()
                        print("Other unexpected error - task: \(error.localizedDescription)")
                        print("Error: \(error)")
                        dump(error)
                    }
                }
                .onChange(of: scenePhase) { oldPhase, newPhase in
                    switch newPhase {
                    case .active:
//                        Task {
//                            // Re-authenticate with biometrics when returning to foreground.
//                            do {
//                                try await AuthorizationManager.instance.enableBiometrics(reason: "Unlock your account")
//                                print("Biometrics enabled/unlocked without prompt - onChange")
//                            } catch BiometricStorageError.biometricsNotAvailable {
//                                // Biometrics unavailable. Authorization will fall back to memory-only tokens.
//                                print("Biometrics not unavailable - onChange")
//                            } catch BiometricStorageError.authenticationFailed {
//                                // User canceled or failed authentication; storage remains locked.
//                                print("Authentication Failed - onChange")
//                            } catch {
//                                // Handle other unexpected errors.
//                                print("Other unexpected error - onChange: \(error.localizedDescription)")
//                                print("Error: \(error)")
//                                dump(error)
//                            }
//                        }
                        print("Unlock Biometrics")

                    case .background:
                        // Lock biometric storage when app goes to background.
                        AuthorizationManager.instance.lockBiometrics()
                        print("Lock Biometrics")

                    default:
                        break
                    }
                }
        }
    }
}
