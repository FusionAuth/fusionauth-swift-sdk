**CLASS**

# `MemoryStorage`

```swift
public class MemoryStorage: Storage
```

TODO
Storage that keeps the data in memory
This storage is not persistent and the data is lost when the app is closed

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
