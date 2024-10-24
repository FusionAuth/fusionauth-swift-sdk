**STRUCT**

# `OAuthAuthorization`

```swift
public struct OAuthAuthorization
```

TODO
OAuthAuthorization is a utility struct that provides methods to resume and cancel the OAuth authorization flow.

## Methods
### `resume(with:)`

```swift
public static func resume(with url: URL) -> Bool
```

Resume the authorization flow with the URL
- Parameter url: The URL to resume the authorization flow
- Returns: A boolean value indicating if the authorization flow was resumed
- Note: This method resumes the authorization flow with the given URL and returns true if the flow was resumed successfully.

#### Parameters

| Name | Description |
| ---- | ----------- |
| url | The URL to resume the authorization flow |

### `cancel()`

```swift
public static func cancel()
```

Cancel the authorization flow
