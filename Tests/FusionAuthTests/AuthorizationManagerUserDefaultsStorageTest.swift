// AuthorizationManager swift test case with UserDefaultsStorage

import XCTest
@testable import FusionAuth

class AuthorizationManagerUserDefaultsStorageTest: XCTestCase {
    var authorizationManager: AuthorizationManager!
    var userDefaultsStorage: UserDefaultsStorage!
    var tokenManager: TokenManager!
    var userInfo: UserInfo!

    override func setUp() {
        super.setUp()
        userDefaultsStorage = UserDefaultsStorage()
        authorizationManager = AuthorizationManager(storage: userDefaultsStorage)
        tokenManager = TokenManager(storage: userDefaultsStorage)
        userInfo = UserInfo(storage: userDefaultsStorage)
    }

    override func tearDown() {
        super.tearDown()
        userDefaultsStorage = nil
        authorizationManager = nil
        tokenManager = nil
        userInfo = nil
    }

    func testAuthorizationManager() {
        let auth = authorizationManager
        XCTAssertNotNil(auth)
    }

    func testTokenManager() {
        let token = tokenManager
        XCTAssertNotNil(token)
    }

    func testUserInfo() {
        let user = userInfo
        XCTAssertNotNil(user)
    }
}