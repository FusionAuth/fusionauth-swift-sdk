enum OAuthError: Error {
    case oIDConfigurationNil
    case authStateNil
    case noAuthorizationCode
    case accessTokenNil
    case userInfoEndpointNotFound
    case userInfoInvalid
    case refreshTokenNil
    case refreshTokenNoResponse
    case unableToUpdateInternalState
}
