// UserInfo swift test case

import XCTest
@testable import FusionAuth

class UserInfoTest: XCTestCase {
    var userInfo: UserInfo!

    override func setUp() {
        super.setUp()
        userInfo = UserInfo()
    }

    override func tearDown() {
        super.tearDown()
        userInfo = nil
    }

    func testUserInfo() {
        let user = userInfo
        XCTAssertNotNil(user)
    }
}
