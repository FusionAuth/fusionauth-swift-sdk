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

### `update(authState:)`

```swift
public func update(authState: FusionAuthStateData)
```

### `update(authState:)`

```swift
public func update(authState: OIDAuthState)
```

### `clear()`

```swift
public func clear()
```
