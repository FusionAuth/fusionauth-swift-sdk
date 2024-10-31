//
//  File.swift
//
//
//  Created by Colin Frick on 15.05.24.
//

import Foundation
import AppAuth

/// The data structure that represents the FusionAuth state.
/// - Note: This data structure contains the access token, refresh token, ID token, and access token expiration time.
public class FusionAuthState: ObservableObject {
    @Published public var accessToken: String?
    @Published public var accessTokenExpirationTime: Date?
    @Published public var idToken: String?
    @Published public var refreshToken: String?

    /// Check if the user is authenticated.
    /// - Returns: A boolean indicating if the user is authenticated
    /// - Note: This method checks if the access token is not nil and the access token expiration time is in the future.
    public func isLoggedIn() -> Bool {
        guard self.accessToken != nil, let expiration = self.accessTokenExpirationTime else {
            return false
        }
        return Date() < expiration
    }

    /// Update the auth state with the given data.
    /// - Parameter authState: The auth state data
    /// - Note: This method updates the FusionAuthStateData access token, refresh token, ID token, and access token expiration time.
    public func update(authState: FusionAuthStateData) {
        self.refreshToken = authState.refreshToken
        self.accessToken = authState.accessToken
        self.accessTokenExpirationTime = authState.accessTokenExpirationTime
        self.idToken = authState.idToken
    }

    /// Update the auth state with the given OIDAuthState.
    /// - Parameter authState: The OIDAuthState object
    /// - Note: This method updates the OIDAuthState access token, refresh token, ID token, and access token expiration time.
    public func update(authState: OIDAuthState) {
        self.refreshToken = authState.refreshToken
        self.accessToken = authState.lastTokenResponse?.accessToken
        self.accessTokenExpirationTime = authState.lastTokenResponse?.accessTokenExpirationDate
        self.idToken = authState.lastTokenResponse?.idToken
    }

    /// Clear the auth state.
    /// - Note: This method clears the access token, refresh token, ID token, and access token expiration time.
    public func clear() {
        self.refreshToken = nil
        self.accessToken = nil
        self.accessTokenExpirationTime = nil
        self.idToken = nil
    }
}
