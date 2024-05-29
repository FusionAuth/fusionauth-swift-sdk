//
//  File.swift
//
//
//  Created by Colin Frick on 15.05.24.
//

import Foundation
import AppAuth

public class FusionAuthState: ObservableObject {

    @Published public var accessToken: String?
    @Published public var accessTokenExpirationTime: Date?
    @Published public var idToken: String?
    @Published public var refreshToken: String?

    public func isLoggedIn() -> Bool {
        guard self.accessToken != nil, let expiration = self.accessTokenExpirationTime else {
            return false
        }
        return Date() < expiration
    }

    public func update(authState: OIDAuthState) {
        self.refreshToken = authState.refreshToken
        self.accessToken = authState.lastTokenResponse?.accessToken
        self.accessTokenExpirationTime = authState.lastTokenResponse?.accessTokenExpirationDate
        self.idToken = authState.lastTokenResponse?.idToken
    }

    public func clear() {
        self.refreshToken = nil
        self.accessToken = nil
        self.accessTokenExpirationTime = nil
        self.idToken = nil
    }

}
