import XCTest
@testable import FusionAuth

final class BiometricStorageTest: XCTestCase {
    private var storage: BiometricStorage!

    override func setUp() {
        super.setUp()
        storage = BiometricStorage()
    }

    override func tearDown() {
        // Clean up any Keychain items written during tests
        storage.remove(key: "testKey")
        storage.remove(key: "key1")
        storage.remove(key: "key2")
        storage = nil
        super.tearDown()
    }

    // MARK: - Initial State

    func testInitialStateIsLocked() {
        XCTAssertTrue(storage.isLocked, "BiometricStorage should start in a locked state")
    }

    func testGetReturnsNilWhenLocked() {
        // Pre-populate memory cache via set (which also writes to Keychain), then lock
        storage.setLockedState(false)
        storage.set(key: "testKey", content: "testValue")
        storage.lock()

        // get() must return nil when locked – regardless of what is in the memory cache
        XCTAssertTrue(storage.isLocked)
        XCTAssertNil(storage.get(key: "testKey"))
    }

    func testGetReturnsValueAfterSetWhileLocked() {
        // set() stores in both memory cache and Keychain regardless of locked state
        // The value should become available after unlocking (simulated with setLockedState)
        storage.set(key: "testKey", content: "persistedValue")

        // While locked, get() returns nil
        XCTAssertTrue(storage.isLocked)
        XCTAssertNil(storage.get(key: "testKey"))

        // After unlocking (simulated), value should be available from the in-memory cache
        // Note: in production, enableBiometrics() would load from Keychain into cache.
        // Here we simulate the post-unlock state using the internal test helper.
        storage.setLockedState(false)
        // Memory cache was populated by set() above, so value is accessible after unlock
        XCTAssertEqual(storage.get(key: "testKey"), "persistedValue")
    }

    // MARK: - Set / Get / Remove (unlocked)

    func testSetAndGetWhenUnlocked() {
        // Use internal helper to simulate a successful biometric unlock
        storage.setLockedState(false)
        storage.set(key: "testKey", content: "testValue")

        XCTAssertEqual(storage.get(key: "testKey"), "testValue")
    }

    func testSetOverwritesExistingValue() {
        storage.setLockedState(false)
        storage.set(key: "testKey", content: "firstValue")
        storage.set(key: "testKey", content: "secondValue")

        XCTAssertEqual(storage.get(key: "testKey"), "secondValue")
    }

    func testRemoveDeletesFromCache() {
        storage.setLockedState(false)
        storage.set(key: "testKey", content: "testValue")
        storage.remove(key: "testKey")

        XCTAssertNil(storage.get(key: "testKey"))
    }

    func testRemoveNonExistentKeyDoesNotCrash() {
        storage.setLockedState(false)
        storage.remove(key: "nonExistentKey")   // Should not throw or crash
    }

    // MARK: - Lock / Unlock

    func testLockClearsMemoryCache() {
        storage.setLockedState(false)
        storage.set(key: "key1", content: "value1")
        storage.set(key: "key2", content: "value2")

        storage.lock()

        XCTAssertTrue(storage.isLocked)
        XCTAssertNil(storage.get(key: "key1"))
        XCTAssertNil(storage.get(key: "key2"))
    }

    func testLockSetsIsLockedTrue() {
        storage.setLockedState(false)
        XCTAssertFalse(storage.isLocked)

        storage.lock()
        XCTAssertTrue(storage.isLocked)
    }

    func testSetLockedStateFalseAllowsReads() {
        storage.setLockedState(false)
        storage.set(key: "testKey", content: "hello")
        XCTAssertEqual(storage.get(key: "testKey"), "hello")
        XCTAssertFalse(storage.isLocked)
    }

    // MARK: - Multiple Values

    func testMultipleKeysStoredAndRetrieved() {
        storage.setLockedState(false)
        storage.set(key: "key1", content: "value1")
        storage.set(key: "key2", content: "value2")

        XCTAssertEqual(storage.get(key: "key1"), "value1")
        XCTAssertEqual(storage.get(key: "key2"), "value2")
    }

    func testRemoveOnlyTargetedKey() {
        storage.setLockedState(false)
        storage.set(key: "key1", content: "value1")
        storage.set(key: "key2", content: "value2")

        storage.remove(key: "key1")

        XCTAssertNil(storage.get(key: "key1"))
        XCTAssertEqual(storage.get(key: "key2"), "value2")
    }

    // MARK: - Biometric Availability

    func testIsBiometricAvailableReturnsBool() {
        // Just verify the property does not crash; the actual boolean depends on device capabilities
        let available = storage.isBiometricAvailable
        XCTAssertNotNil(available)
    }

    // MARK: - enableBiometrics unavailable

    func testEnableBiometricsThrowsWhenUnavailable() async {
        // In a simulator / CI environment without biometrics enrolled, this should throw
        guard !storage.isBiometricAvailable else {
            // Skip this test on devices / simulators that do have biometrics available
            return
        }

        do {
            try await storage.enableBiometrics(reason: "Test unlock")
            XCTFail("Expected BiometricStorageError.biometricsNotAvailable to be thrown")
        } catch BiometricStorageError.biometricsNotAvailable {
            // Expected
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // MARK: - AuthorizationManager Integration

    func testAuthorizationManagerWithBiometricStorage() {
        let config = AuthorizationConfiguration(
            clientId: "test-client",
            fusionAuthUrl: "https://fusionauth.example.com"
        )
        let biometricStorage = BiometricStorage()
        let manager = AuthorizationManager.instance
        manager.initialize(configuration: config, storage: biometricStorage)

        // isBiometricStorageLocked should reflect the storage's locked state
        XCTAssertEqual(manager.isBiometricStorageLocked, true)

        biometricStorage.setLockedState(false)
        XCTAssertEqual(manager.isBiometricStorageLocked, false)

        // Cleanup
        try? manager.clearAllState()
    }

    func testLockBiometricsViaAuthorizationManager() {
        let config = AuthorizationConfiguration(
            clientId: "test-client",
            fusionAuthUrl: "https://fusionauth.example.com"
        )
        let biometricStorage = BiometricStorage()
        biometricStorage.setLockedState(false)
        biometricStorage.set(key: "testKey", content: "value")

        let manager = AuthorizationManager.instance
        manager.initialize(configuration: config, storage: biometricStorage)

        // Lock via manager
        manager.lockBiometrics()

        XCTAssertTrue(biometricStorage.isLocked)
        XCTAssertNil(biometricStorage.get(key: "testKey"))

        // Cleanup
        try? manager.clearAllState()
    }

    func testEnableBiometricsThrowsNotBiometricStorageWhenWrongStorage() async {
        let config = AuthorizationConfiguration(
            clientId: "test-client",
            fusionAuthUrl: "https://fusionauth.example.com"
        )
        // Initialize with MemoryStorage (not BiometricStorage)
        let manager = AuthorizationManager.instance
        manager.initialize(configuration: config, storage: MemoryStorage())

        do {
            try await manager.enableBiometrics()
            XCTFail("Expected BiometricStorageError.notBiometricStorage to be thrown")
        } catch BiometricStorageError.notBiometricStorage {
            // Expected
        } catch {
            XCTFail("Unexpected error: \(error)")
        }

        // isBiometricStorageLocked returns nil for non-biometric storage
        XCTAssertNil(manager.isBiometricStorageLocked)

        // Cleanup
        try? manager.clearAllState()
    }

    func testLockBiometricsIsNoOpForNonBiometricStorage() {
        let config = AuthorizationConfiguration(
            clientId: "test-client",
            fusionAuthUrl: "https://fusionauth.example.com"
        )
        let manager = AuthorizationManager.instance
        manager.initialize(configuration: config, storage: MemoryStorage())

        // Should not crash
        manager.lockBiometrics()

        // Cleanup
        try? manager.clearAllState()
    }
}
