// AuthorizationManager swift test case with KeyChainStorage

import XCTest
@testable import FusionAuth

class AuthorizationManagerKeyChainStorageTest: XCTestCase {
    var authorizationManager: AuthorizationManager!
    var keyChainStorage: KeyChainStorage!
    var tokenManager: TokenManager!
    var userInfo: UserInfo!

    override func setUp() {
        super.setUp()
        keyChainStorage = KeyChainStorage()
        tokenManager = TokenManager()
        userInfo = UserInfo()
    }

    override func tearDown() {
        super.tearDown()
        keyChainStorage = nil
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
