//
//  AuthorizationManager+Initialization.swift
//  fusionauth-quickstart-swift-ios-native
//
//  Created by Colin Frick on 31.08.24.
//

import Foundation
import FusionAuth

extension AuthorizationManager {
    /// We use a shared instance of the AuthorizationManager to ensure that we only have one instance of the AuthorizationManager
    /// in our application.
    ///
    /// This shared instance is initialized with the configuration for the FusionAuth server and the client ID.
    public static let shared: AuthorizationManager = {
        let instance = AuthorizationManager.instance
        instance.initialize(configuration: AuthorizationConfiguration(
                                clientId: "e9fdb985-9173-4e01-9d73-ac2d60d1dc8e",
                                fusionAuthUrl: "http://localhost:9011",
                                additionalScopes: ["email", "profile"])
        )
        return instance
    }()
}
