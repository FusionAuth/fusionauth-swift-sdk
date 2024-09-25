**CLASS**

# `FusionAuthState`

```swift
public class FusionAuthState: ObservableObject
```

TODO
FusionAuthState is an observable object that represents the authorization state of the user.
It provides properties to store and retrieve access tokens, refresh tokens, and ID tokens.
It also provides a method to check if the user is authenticated.

## Properties
### `accessToken`

```swift
@Published public var accessToken: String?
```

### `accessTokenExpirationTime`

```swift
@Published public var accessTokenExpirationTime: Date?
```

### `idToken`

```swift
@Published public var idToken: String?
```

### `refreshToken`

```swift
@Published public var refreshToken: String?
```

## Methods
### `isLoggedIn()`

```swift
public func isLoggedIn() -> Bool
```

Check if the user is authenticated
- Returns: A boolean indicating if the user is authenticated
- Note: This method checks if the access token is not nil and the access token expiration time is in the future.

### `update(authState:)`

```swift
public func update(authState: FusionAuthStateData)
```

Update the auth state with the given data
- Parameter authState: The auth state data
- Returns: Void
- Note: This method updates the FusionAuthStateData access token, refresh token, ID token, and access token expiration time.

#### Parameters

| Name | Description |
| ---- | ----------- |
| authState | The auth state data |

### `update(authState:)`

```swift
public func update(authState: OIDAuthState)
```

Update the auth state with the given OIDAuthState
- Parameter authState: The OIDAuthState object
- Returns: Void
- Note: This method updates the OIDAuthState access token, refresh token, ID token, and access token expiration time.

#### Parameters

| Name | Description |
| ---- | ----------- |
| authState | The OIDAuthState object |

### `clear()`

```swift
public func clear()
```

Clear the auth state
- Returns: Void
- Note: This method clears the access token, refresh token, ID token, and access token expiration time.
