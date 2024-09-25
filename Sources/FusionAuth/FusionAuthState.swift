//
//  File.swift
//
//
//  Created by Colin Frick on 15.05.24.
//

import Foundation
import AppAuth

/// TODO
/// FusionAuthState is an observable object that represents the authorization state of the user.
/// It provides properties to store and retrieve access tokens, refresh tokens, and ID tokens.
/// It also provides a method to check if the user is authenticated.
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

    public func update(authState: FusionAuthStateData) {
        self.refreshToken = authState.refreshToken
        self.accessToken = authState.accessToken
        self.accessTokenExpirationTime = authState.accessTokenExpirationTime
        self.idToken = authState.idToken
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
