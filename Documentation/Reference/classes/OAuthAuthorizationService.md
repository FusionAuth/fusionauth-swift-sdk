**CLASS**

# `OAuthAuthorizationService`

```swift
public class OAuthAuthorizationService
```

OAuthAuthorizationService class is responsible for handling OAuth authorization and authorization process.
It provides methods to authorize the user, handle the redirect intent, fetch user information,
perform logout, retrieve fresh access token, and get the authorization service.

## Methods
### `authorize(options:)`

```swift
public func authorize(options: OAuthAuthorizeOptions) async throws -> OIDAuthState
```

### `userInfo()`

```swift
public func userInfo() async throws -> UserInfo
```

### `logout(options:)`

```swift
public func logout(options: OAuthLogoutOptions) async throws
```

### `freshAccessToken()`

```swift
public func freshAccessToken() async throws -> String?
```
