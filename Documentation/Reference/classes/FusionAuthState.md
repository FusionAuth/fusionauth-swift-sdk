**CLASS**

# `FusionAuthState`

```swift
public class FusionAuthState: ObservableObject
```

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
public func update(authState: OIDAuthState)
```

### `clear()`

```swift
public func clear()
```
