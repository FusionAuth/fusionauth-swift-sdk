**STRUCT**

# `OAuthDeviceAuthorizeOptions`

```swift
public struct OAuthDeviceAuthorizeOptions
```

OAuthDeviceAuthorizeOptions is a data class that represents the options for the OAuth device authorization request.

See [FusionAuth OAuth 2.0 Device Authorization Endpoint](https://fusionauth.io/docs/apis/identity-providers/oauth2#start-the-device-authorization-grant)
for more information.

## Methods
### `init(clientSecret:idpHint:loginHint:deviceDescription:additionalParameters:scopes:)`

```swift
public init(
    clientSecret: String? = nil,
    idpHint: String? = nil,
    loginHint: String? = nil,
    deviceDescription: String? = nil,
    additionalParameters: [String: String] = [:],
    scopes: [String]? = nil
)
```

Creates a new instance of OAuthDeviceAuthorizeOptions.
