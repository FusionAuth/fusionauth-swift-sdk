**CLASS**

# `KeyChainStorage`

```swift
public class KeyChainStorage: Storage
```

TODO
Storage that saves data to the KeyChain
This storage is secure and the data is encrypted
The data is persisted even when the app is closed

## Methods
### `init()`

```swift
public init()
```

### `get(key:)`

```swift
public func get(key: String) -> String?
```

### `set(key:content:)`

```swift
public func set(key: String, content: Any)
```

### `remove(key:)`

```swift
public func remove(key: String)
```
