// AuthorizationManager swift test case with UserDefaultsStorage

import XCTest
@testable import FusionAuth

final class AuthManagerUserDefaultsStorageTest: XCTestCase {
    private var authorizationManager: AuthorizationManager!
    private var userDefaultsStorage: UserDefaultsStorage!
    private var tokenManager: TokenManager!
    private var userInfo: UserInfo!

    override func setUp() {
        super.setUp()
        userDefaultsStorage = UserDefaultsStorage()
        tokenManager = TokenManager()
        userInfo = UserInfo()
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
