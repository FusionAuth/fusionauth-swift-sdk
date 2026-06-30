import XCTest
@testable import FusionAuth

final class OAuthDeviceAuthorizeOptionsTest: XCTestCase {
    func testOAuthDeviceAuthorizeOptionsDefaults() {
        let options = OAuthDeviceAuthorizeOptions()

        XCTAssertNil(options.clientSecret)
        XCTAssertNil(options.idpHint)
        XCTAssertNil(options.loginHint)
        XCTAssertNil(options.deviceDescription)
        XCTAssertTrue(options.additionalParameters.isEmpty)
        XCTAssertNil(options.scopes)
    }

    func testOAuthDeviceAuthorizeOptionsWithCustomValues() {
        let options = OAuthDeviceAuthorizeOptions(
            clientSecret: "secret",
            idpHint: "google",
            loginHint: "jane@example.com",
            deviceDescription: "Living Room TV",
            additionalParameters: ["custom": "value"],
            scopes: ["openid", "profile"]
        )

        XCTAssertEqual(options.clientSecret, "secret")
        XCTAssertEqual(options.idpHint, "google")
        XCTAssertEqual(options.loginHint, "jane@example.com")
        XCTAssertEqual(options.deviceDescription, "Living Room TV")
        XCTAssertEqual(options.additionalParameters["custom"], "value")
        XCTAssertEqual(options.scopes ?? [], ["openid", "profile"])
    }
}
