import Foundation

/// Storage that saves data to UserDefaults
public class UserDefaultsStorage: Storage {
    public init() {}

    public func get(key: String) -> String? {
        UserDefaults.standard.string(forKey: key)
    }

    public func set(key: String, content: Any) {
        UserDefaults.standard.setValue(content, forKey: key)
    }

    public func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
