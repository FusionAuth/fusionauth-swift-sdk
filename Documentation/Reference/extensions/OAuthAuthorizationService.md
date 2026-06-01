**EXTENSION**

# `OAuthAuthorizationService`
```swift
extension OAuthAuthorizationService
```

## Methods
### `authorizeDevice(options:onUserCodeReceived:)`

```swift
public func authorizeDevice(
    options: OAuthDeviceAuthorizeOptions = OAuthDeviceAuthorizeOptions(),
    onUserCodeReceived: @escaping (OAuthDeviceAuthorizationData) -> Void
) async throws -> OIDAuthState
```

Starts OAuth Device Authorization Grant flow and polls for completion.

- Parameter options: The options to configure the device authorization request.
- Parameter onUserCodeReceived: Called when user verification data is available.
- Returns: The OAuth authorization state once the device authorization flow completes.

#### Parameters

| Name | Description |
| ---- | ----------- |
| options | The options to configure the device authorization request. |
| onUserCodeReceived | Called when user verification data is available. |

### `cancelDeviceAuthorization()`

```swift
public func cancelDeviceAuthorization()
```

Cancels an active OAuth Device Authorization Grant request.

### `authorize(options:)`

```swift
public func authorize(options: OAuthAuthorizeOptions) async throws -> OIDAuthState
```

Authorizes the user using OAuth authorization code flow.

- Parameter options: The options to configure the OAuth logout request.
- Returns: The OAuth authorization state.

#### Parameters

| Name | Description |
| ---- | ----------- |
| options | The options to configure the OAuth logout request. |

### `logout(options:)`

```swift
public func logout(options: OAuthLogoutOptions) async throws
```

Log out the user

- Parameter options: The options to configure the OAuth logout request.

#### Parameters

| Name | Description |
| ---- | ----------- |
| options | The options to configure the OAuth logout request. |

### `userInfo()`

```swift
public func userInfo() async throws -> UserInfo
```

Retrieves the user information for the authenticated user.

- Returns: The user information
- Throws: An error if the user information is not found.

### `freshAccessToken()`

```swift
public func freshAccessToken() async throws -> String?
```

Retrieves a fresh access token.

- Returns: The fresh access token or nil if an error occurs.
