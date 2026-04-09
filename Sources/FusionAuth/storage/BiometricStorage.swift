import Foundation
import LocalAuthentication
import Security

/// Errors that can occur when using ``BiometricStorage`` or when calling biometric-related
/// methods on ``AuthorizationManager``.
public enum BiometricStorageError: Error {
    /// Biometric authentication is not available on this device.
    ///
    /// This can happen when no Face ID or Touch ID is enrolled, or when no passcode is set
    /// (required by `kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly`).
    case biometricsNotAvailable

    /// The user failed or cancelled the biometric authentication prompt.
    case authenticationFailed

    /// The ``AuthorizationManager`` was not initialized with a ``BiometricStorage`` instance.
    ///
    /// Thrown by ``AuthorizationManager/enableBiometrics(reason:)`` when the current storage
    /// backend is not a ``BiometricStorage``.
    case notBiometricStorage

    /// A Security framework Keychain error occurred.
    ///
    /// The associated `OSStatus` value contains the raw Keychain status code.
    case keychainError(OSStatus)
}

/// A `Storage` implementation that protects tokens using biometric authentication (Face ID / Touch ID).
///
/// Tokens are persisted in the Keychain with biometric access control, meaning the device's
/// biometric system must authenticate the user before the Keychain will release the data.
/// After a successful biometric unlock, the decrypted values are cached in memory for fast
/// synchronous access until `lock()` is called or the store is otherwise cleared.
///
/// ## Lifecycle
/// 1. Initialize the `AuthorizationManager` with a `BiometricStorage` instance.
/// 2. After app launch, call `enableBiometrics(reason:)` to authenticate the user and load
///    tokens from the Keychain into the in-memory cache.
/// 3. Token reads and writes work normally via the `Storage` protocol while the store is unlocked.
/// 4. Call `lock()` to clear the in-memory cache (e.g., when the app enters the background or
///    after a period of inactivity). The next call to `enableBiometrics(reason:)` will
///    re-authenticate and reload from the Keychain.
///
/// ## Biometric Decline
/// If the user declines biometric authentication (or biometrics are unavailable), callers
/// should fall back to `MemoryStorage` to provide an in-memory-only session, which requires
/// re-authentication via FusionAuth on each app launch.
///
/// ## Example
/// ```swift
/// let biometricStorage = BiometricStorage()
/// AuthorizationManager.instance.initialize(configuration: config, storage: biometricStorage)
///
/// // Unlock on app foreground
/// do {
///     try await biometricStorage.enableBiometrics(reason: "Unlock to access your account")
/// } catch BiometricStorageError.biometricsNotAvailable {
///     // Fall back to memory-only storage
/// } catch BiometricStorageError.authenticationFailed {
///     // User cancelled – keep store locked
/// }
///
/// // Lock on app background
/// biometricStorage.lock()
/// ```
public class BiometricStorage: Storage {
    /// The Keychain service name used to namespace biometrically-protected items.
    internal static let serviceName = "io.fusionauth.mobilesdk.biometric"

    /// In-memory cache of decrypted token values. Populated on unlock, cleared on lock.
    private var memoryCache: [String: String] = [:]

    /// Whether the store is currently locked (i.e., the in-memory cache has been cleared).
    /// When `true`, `get(key:)` returns `nil` until `enableBiometrics(reason:)` is called.
    public private(set) var isLocked = true

    public init() {}

    // MARK: - Storage Protocol

    /// Returns the cached value for the key.
    ///
    /// Returns `nil` when the store is locked. Call `enableBiometrics(reason:)` first to
    /// load values from the Keychain into the in-memory cache.
    public func get(key: String) -> String? {
        guard !isLocked else { return nil }
        return memoryCache[key]
    }

    /// Stores the value in both the in-memory cache and the biometric-protected Keychain.
    ///
    /// This method persists the value regardless of the current locked/unlocked state so
    /// that freshly-written tokens survive app restarts and can be recovered on the next
    /// biometric unlock.
    public func set(key: String, content: Any) {
        let value = String(describing: content)
        memoryCache[key] = value
        saveToKeychain(key: key, value: value)
    }

    /// Removes the value from both the in-memory cache and the Keychain.
    public func remove(key: String) {
        memoryCache.removeValue(forKey: key)
        removeFromKeychain(key: key)
    }

    // MARK: - Biometric API

    /// `true` when the device supports and has biometric authentication enrolled and a
    /// passcode set (required by `kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly`).
    public var isBiometricAvailable: Bool {
        let context = LAContext()
        var error: NSError?
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    /// Clears the in-memory token cache and marks the store as locked.
    ///
    /// After calling `lock()`, `get(key:)` will return `nil` until `enableBiometrics(reason:)`
    /// is successfully called again. Tokens remain encrypted in the Keychain.
    public func lock() {
        memoryCache.removeAll()
        isLocked = true
    }

    /// Authenticates the user with biometrics and, on success, loads all persisted tokens from
    /// the Keychain into the in-memory cache, transitioning the store to the unlocked state.
    ///
    /// Authentication is enforced by the Keychain's Secure Enclave access control
    /// (`.biometryCurrentSet`), making it hardware-backed. The `LAContext` is only used to
    /// provide an early availability check and a localised reason string for the system prompt.
    ///
    /// - Parameter reason: The localized reason string presented to the user in the
    ///   system biometric prompt.
    /// - Throws: `BiometricStorageError.biometricsNotAvailable` if Face ID / Touch ID is not
    ///   available or not enrolled on this device.
    /// - Throws: `BiometricStorageError.authenticationFailed` if the user cancels or fails
    ///   authentication.
    /// - Throws: `BiometricStorageError.keychainError` if reading items from the Keychain fails.
    public func enableBiometrics(reason: String = "Authenticate to access your account") async throws {
        let context = LAContext()
        var policyError: NSError?

        // Early capability check – provides a meaningful error before attempting Keychain access.
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &policyError) else {
            throw BiometricStorageError.biometricsNotAvailable
        }

        // The localised reason is shown in the system biometric prompt that the Keychain
        // triggers automatically when reading items protected with .biometryCurrentSet.
        context.localizedReason = reason

        // SecItemCopyMatching blocks until the user authenticates (or cancels).
        // Wrapping it in a detached Task keeps the caller's thread free.
        // Authentication is enforced entirely by the Keychain / Secure Enclave – the
        // security boundary is not a bypassable boolean but the hardware-backed ACL.
        try await Task.detached(priority: .userInitiated) { [self] in
            try self.loadKeychainItems(context: context)
        }.value

        isLocked = false
    }

    // MARK: - Private Keychain Helpers

    private func saveToKeychain(key: String, value: String) {
        removeFromKeychain(key: key)

        guard let data = value.data(using: .utf8) else {
            AuthorizationManager.log?.warning("BiometricStorage: UTF-8 encoding failed for key '\(key)'; value will not persist across app restarts.")
            return
        }

        var cfError: Unmanaged<CFError>?
        guard let access = SecAccessControlCreateWithFlags(
            kCFAllocatorDefault,
            kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
            .biometryCurrentSet,
            &cfError
        ) else {
            AuthorizationManager.log?.warning("BiometricStorage: Failed to create access control for key '\(key)': \(String(describing: cfError))")
            return
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Self.serviceName,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessControl as String: access
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            AuthorizationManager.log?.warning("BiometricStorage: Keychain write failed for key '\(key)' with status \(status); value will not persist across app restarts.")
        }
    }

    private func removeFromKeychain(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Self.serviceName,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }

    /// Reads all items stored under the SDK's service name using the provided `LAContext`.
    ///
    /// When items are protected with `.biometryCurrentSet`, `SecItemCopyMatching` blocks and
    /// shows the system biometric prompt. On cancellation or failure the Keychain returns
    /// `errSecUserCanceled` or `errSecAuthFailed`, which are mapped to
    /// `BiometricStorageError.authenticationFailed`.
    private func loadKeychainItems(context: LAContext) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Self.serviceName,
            kSecReturnData as String: true,
            kSecReturnAttributes as String: true,
            kSecMatchLimit as String: kSecMatchLimitAll,
            kSecUseAuthenticationContext as String: context
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        switch status {
        case errSecSuccess:
            if let items = result as? [[String: Any]] {
                for item in items {
                    if let account = item[kSecAttrAccount as String] as? String,
                       let data = item[kSecValueData as String] as? Data,
                       let value = String(data: data, encoding: .utf8) {
                        memoryCache[account] = value
                    }
                }
            }
        case errSecItemNotFound:
            // No items stored yet — treat as a successful unlock with an empty cache.
            break
        case errSecUserCanceled, errSecAuthFailed:
            throw BiometricStorageError.authenticationFailed
        default:
            throw BiometricStorageError.keychainError(status)
        }
    }
}

// MARK: - Testing Support

extension BiometricStorage {
    /// Sets the locked state directly without biometric authentication.
    ///
    /// - Note: This method is intended for unit testing only. If called with `false`
    ///   the in-memory cache is not populated from the Keychain; callers must pre-populate
    ///   the cache via `set(key:content:)` before using `get(key:)`.
    internal func setLockedState(_ locked: Bool) {
        isLocked = locked
    }
}
