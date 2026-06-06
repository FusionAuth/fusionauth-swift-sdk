import XCTest

@MainActor
final class QuickstartTVOSTests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() async throws {
        continueAfterFailure = false
        await MainActor.run {
            app = XCUIApplication()
            app.launch()
        }
    }

    override func tearDown() async throws {
        await MainActor.run {
            let logoutButton = app.buttons["Log out"]
            if logoutButton.exists && logoutButton.isHittable {
                logoutButton.tap()
                let loginButton = app.buttons["Login"]
                XCTAssertTrue(loginButton.waitForExistence(timeout: 30), "Login button should appear after logging out")
            }
        }
    }

    /// Verifies that tapping Login triggers the device authorization flow and
    /// shows a device user code on screen.
    @MainActor
    func testLoginShowsDeviceCode() throws {
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 30), "Login button should be visible")
        loginButton.tap()

        // The device authorization flow should display a user code within a
        // reasonable time once FusionAuth responds with the device code endpoint.
        let deviceCode = app.staticTexts["DeviceUserCode"]
        XCTAssertTrue(deviceCode.waitForExistence(timeout: 60), "Device user code should appear after tapping Login")
        XCTAssertFalse(deviceCode.label.isEmpty, "Device user code label should not be empty")
    }
}
