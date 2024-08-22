**STRUCT**

# `OAuthAuthorizeOptions`

```swift
public struct OAuthAuthorizeOptions
```

OAuthAuthorizeOptions is a data class that represents the options for the OAuth authorize request.

See [FusionAuth OAuth 2.0 Authorization Endpoint](https://fusionauth.io/docs/lifecycle/authenticate-users/oauth/endpoints#authorize)
for more information.

## Methods
### `init(redirectUri:idpHint:codeChallenge:codeChallengeMethod:loginHint:deviceDescription:nonce:state:userCode:)`

```swift
public init(
    redirectUri: String = "\(Bundle.main.bundleIdentifier ?? ""):/oauth2redirect/ios-provider",
    idpHint: String? = nil,
    codeChallenge: String? = nil,
    codeChallengeMethod: OAuthCodeChallengeMethod? = nil,
    loginHint: String? = nil,
    deviceDescription: String? = nil,
    nonce: String? = nil,
    state: String? = nil,
    userCode: String? = nil
)
```
