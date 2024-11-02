//
//  QuickstartApp.swift
//  Quickstart
//
//  Created by Colin Frick on 24.04.24.
//

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
