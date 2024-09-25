/// TODO
/// Storage that keeps the data in memory
/// This storage is not persistent and the data is lost when the app is closed
public class MemoryStorage: Storage {
    public init() {}

    private var storageDictionary: [String: Any] = [:]

    public func get(key: String) -> String? {
        if let value = storageDictionary[key] {
            return String(describing: value)
        } else {
            return nil
        }
    }

    public func set(key: String, content: Any) {
        self.storageDictionary[key] = content
    }

    public func remove(key: String) {
        storageDictionary.removeValue(forKey: key)
    }

}
