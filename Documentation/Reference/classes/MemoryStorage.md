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

Retrieves the value associated with the given key from the storage.
- Parameters:
  - key: The key for which to retrieve the value.
- Returns: The value associated with the key, or null if the key is not found in the storage.
- Note: This method retrieves the value associated with the given key from the storage and returns it as a string.

#### Parameters

| Name | Description |
| ---- | ----------- |
| key | The key for which to retrieve the value. |

### `set(key:content:)`

```swift
public func set(key: String, content: Any)
```

Sets the value associated with the given key in the storage.
- Parameters:
  - key: The key for which to set the value.
  - content: The value to be set for the key.
- Returns: Void

#### Parameters

| Name | Description |
| ---- | ----------- |
| key | The key for which to set the value. |
| content | The value to be set for the key. |

### `remove(key:)`

```swift
public func remove(key: String)
```

Removes the value associated with the given key from the storage.
- Parameters:
  - key: The key for which to remove the value.
- Returns: Void

#### Parameters

| Name | Description |
| ---- | ----------- |
| key | The key for which to remove the value. |