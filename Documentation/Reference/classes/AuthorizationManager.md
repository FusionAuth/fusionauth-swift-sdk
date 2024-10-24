**CLASS**

# `AuthorizationManager`

```swift
public class AuthorizationManager
```

AuthorizationManager is a singleton object that manages the authorization state of the user.
It provides methods to initialize the authorization manager, check if the user is authenticated,
retrieve access tokens, refresh access tokens, and clear the authorization state.

AuthorizationManager uses a TokenManager to manage the access tokens and a Storage implementation
to store the authorization state.

## Properties
### `instance`

```swift
public static let instance = AuthorizationManager()
```

## Methods
### `initialize(configuration:storage:)`

```swift
public func initialize(configuration: AuthorizationConfiguration, storage: Storage? = nil)
```

### `fusionAuthState()`

```swift
public func fusionAuthState() -> FusionAuthState
```

### `getTokenManager()`

```swift
public func getTokenManager() -> TokenManager
```

### `oauth()`

```swift
public func oauth() -> OAuthAuthorizationService
```

### `freshAccessToken(force:)`

```swift
public func freshAccessToken(force: Bool = false) async throws -> String?
```

### `getAccessToken()`

```swift
public func getAccessToken() -> String?
```

### `getAccessTokenExpirationTime()`

```swift
public func getAccessTokenExpirationTime() -> Date?
```

### `isAccessTokenExpired()`

```swift
public func isAccessTokenExpired() -> Bool
```

### `updateAuthState(authState:)`

```swift
public func updateAuthState(authState: OIDAuthState) throws
```

### `updateAuthState(accessToken:accessTokenExpirationTime:idToken:refreshToken:)`

```swift
public func updateAuthState(accessToken: String, accessTokenExpirationTime: Date, idToken: String, refreshToken: String) throws
```

### `clearState()`

```swift
public func clearState() throws
```
