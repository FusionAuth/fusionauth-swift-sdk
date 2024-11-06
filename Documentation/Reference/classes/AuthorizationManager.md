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

The shared instance of the AuthorizationManager

## Methods
### `initialize(configuration:storage:)`

```swift
@discardableResult public func initialize(configuration: AuthorizationConfiguration, storage: Storage? = nil) -> Self
```

Initialize the AuthorizationManager with the given configuration

### `getTokenManager()`

```swift
public func getTokenManager() -> TokenManager
```

Returns the current TokenManager

### `freshAccessToken(force:)`

```swift
public func freshAccessToken(force: Bool = false) async throws -> String?
```

Returns a fresh access token

If the access token is not expired, it will be returned immediately.
If the access token is expired or force is `true`, a new access token will be fetched using the refresh token.

### `getAccessToken()`

```swift
public func getAccessToken() -> String?
```

Retrieves the access token, if available

### `getAccessTokenExpirationTime()`

```swift
public func getAccessTokenExpirationTime() -> Date?
```

Retrieves the access token expiration, if available

### `isAccessTokenExpired()`

```swift
public func isAccessTokenExpired() -> Bool
```

Checks if the stored access token is expired.

### `getIdToken()`

```swift
public func getIdToken() -> String?
```

Retrieves the ID token, if available
