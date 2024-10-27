//
//  LoginView.swift
//  Quickstart
//
//  Created by Colin Frick on 15.05.24.
//

import SwiftUI
import FusionAuth

struct LoginView: View {

    var body: some View {
        VStack {
            Image("changebank")
                .resizable()
                .aspectRatio(contentMode: .fit)

            Text("Welcome to ChangeBank!")

            Button("Login") {
                Task {
                    do {
                        try await AuthorizationManager.shared
                            .oauth()
                            .authorize(options: OAuthAuthorizeOptions())
                    } catch {
                        print("Error occured")
                    }
                }
            }.buttonStyle(PrimaryButtonStyle())

        }
        .padding()
    }
}

#if swift(>=5.9)
#Preview {
    LoginView()
}
#else
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
