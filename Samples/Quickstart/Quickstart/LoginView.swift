import SwiftUI
import FusionAuth

struct LoginView: View {
    @State private var errorWhileLogin = false
    @State private var error: String?

    #if os(tvOS)
    @State private var userCode: String?
    @State private var verificationURI: URL?
    @State private var isAuthorizing = false
    #endif

    /// Reads the optional `prompt` value injected by UI tests via the
    /// `--prompt-parameter <value>` launch argument.
    private var promptFromLaunchArguments: String? {
        let args = ProcessInfo.processInfo.arguments
        guard let idx = args.firstIndex(of: "--prompt-parameter"),
              args.indices.contains(idx + 1)
        else { return nil }
        return args[idx + 1]
    }

    var body: some View {
        #if os(tvOS)
        tvOSBody
        #else
        iOSBody
        #endif
    }

    #if os(tvOS)
    @ViewBuilder
    private var tvOSBody: some View {
        VStack(spacing: 24) {
            Image("changebank")
                .resizable()
                .scaledToFit()

            Text("Welcome to ChangeBank!")
                .font(.title)

            if isAuthorizing, let userCode, let verificationURI {
                VStack(spacing: 16) {
                    Text("To log in, visit this URL on another device:")
                        .font(.headline)
                    Text(verificationURI.absoluteString)
                        .font(.body)
                        .foregroundColor(.secondary)
                    Text("Then enter this code:")
                        .font(.headline)
                        .padding(.top)
                    Text(userCode)
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                        .accessibilityIdentifier("DeviceUserCode")
                    ProgressView()
                        .padding(.top)
                }
                .padding()
            } else {
                Button("Login") {
                    isAuthorizing = true
                    Task {
                        do {
                            try await AuthorizationManager
                                .oauth()
                                .authorize(options: OAuthAuthorizeOptions(
                                    deviceAuthorizationCallback: { code, uri in
                                        Task { @MainActor in
                                            self.userCode = code
                                            self.verificationURI = uri
                                        }
                                    }
                                ))
                        } catch let error as NSError {
                            self.isAuthorizing = false
                            self.userCode = nil
                            self.verificationURI = nil
                            self.errorWhileLogin = true
                            self.error = error.localizedDescription
                        }
                    }
                }.buttonStyle(PrimaryButtonStyle())
            }
        }
        .padding()
        .alert(
            "Error occurred while logging in",
            isPresented: $errorWhileLogin,
            presenting: error
        ) { _ in
            Button("OK", role: .cancel) { errorWhileLogin = false }
        } message: { error in
            Text(error)
        }
    }
    #else
    @ViewBuilder
    private var iOSBody: some View {
        VStack {
            Image("changebank")
                .resizable()
                .scaledToFit()

            Text("Welcome to ChangeBank!")

            Button("Login") {
                Task {
                    do {
                        try await AuthorizationManager
                            .oauth()
                            .authorize(options: OAuthAuthorizeOptions(prompt: promptFromLaunchArguments))
                    } catch let error as NSError {
                        self.errorWhileLogin = true
                        self.error = error.localizedDescription
                    }
                }
            }.buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .alert(
            "Error occurred while logging in",
            isPresented: $errorWhileLogin,
            presenting: error
        ) { _ in
            Button("OK", role: .cancel) { errorWhileLogin = false }
        } message: { error in
            Text(error)
        }
    }
    #endif
}
