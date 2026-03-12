import XCTest

final class QuickstartTests: XCTestCase {
    private var primaryLogin = "richard@example.com"
    private var primaryWelcomeName = "Richard Hendricks"
    private var alternateLogin = "mike@example.com"
    private var alternateWelcomeName = "Mike Hendricks"

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()

        continueAfterFailure = false

        app.launch()
    }

    override func tearDownWithError() throws {
        // Attempt to log out after each test if user is logged in
        let logoutButton = app.buttons["Log out"]
        if logoutButton.exists && logoutButton.isHittable {
            logoutButton.tap()
            confirmLoginAlert(app)
            // Wait for login button to reappear
            let loginButton = app.buttons["Login"]
            XCTAssertTrue(loginButton.waitForExistence(timeout: 30), "Login button should appear after logging out")
        }
    }

    private func confirmLoginAlert(_ app: XCUIApplication) {
        var alertPresent = false

        let predicate = NSPredicate { evaluatedObject, _ in
            let application = evaluatedObject as? XCUIApplication
            application?.tap()
            return alertPresent
        }

        let alertMonitor = addUIInterruptionMonitor(withDescription: "Login Alert") { alert -> Bool in
            alert.buttons["Continue"].tap()
            alertPresent = true
            return true
        }

        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: app)
        wait(for: [expectation], timeout: 120)
        removeUIInterruptionMonitor(alertMonitor)
    }

    private func dismissPasswordSavePrompt(_ app: XCUIApplication) {
        var alertHandled = false

        let handledExpectation = expectation(description: "Password Save Prompt handled")
        let alertMonitor = addUIInterruptionMonitor(withDescription: "Password Save Prompt") { alert -> Bool in
            let buttons = alert.buttons
            if buttons["Don't Save"].exists {
                buttons["Don't Save"].tap()
            } else if buttons["Not Now"].exists {
                buttons["Not Now"].tap()
            } else if buttons["Never for This Website"].exists {
                buttons["Never for This Website"].tap()
            } else if buttons["Cancel"].exists {
                buttons["Cancel"].tap()
            } else {
                return false
            }
            if !alertHandled {
                alertHandled = true
                handledExpectation.fulfill()
            }
            return true
        }

        // ensure the alert monitor is cleaned up after handling the password prompt.
        defer { removeUIInterruptionMonitor(alertMonitor) }

        // Repeatedly tap to surface the prompt for a short window so the interruption monitor can intercept it.
        // This mirrors the pattern used in confirmLoginAlert to reliably trigger the handler.
        let start = Date()
        let timeout: TimeInterval = 3
        while !alertHandled && Date().timeIntervalSince(start) < timeout {
            app.tap()
            // Give the system a moment to present the alert and for the monitor to run.
            RunLoop.current.run(until: Date().addingTimeInterval(0.15))
        }

        // As a final nudge in case the alert appeared right after the loop ends, tap once more.
        if !alertHandled { app.tap() }

        // Do a very short wait to allow the handler to fulfill if it just fired.
        _ = XCTWaiter().wait(for: [handledExpectation], timeout: 0.5)
    }

    private func waitUntilHittable(_ element: XCUIElement, timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate(format: "exists == true AND hittable == true")
        let exp = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [exp], timeout: timeout)
        return result == .completed
    }

    private func focusTextField(_ field: XCUIElement, timeout: TimeInterval = 5) {
        let deadline = Date().addingTimeInterval(timeout)
        var lastError: String?

        while Date() < deadline {
            if field.exists && field.isHittable {
                field.tap()
                // Give the UI a moment to react after the tap.
                RunLoop.current.run(until: Date().addingTimeInterval(0.15))
                if field.hasFocus {
                    return
                }
                lastError = "Tapped but field did not gain focus."
            } else {
                lastError = "Field not hittable."
            }
            // Small backoff to let overlays/animations settle.
            RunLoop.current.run(until: Date().addingTimeInterval(0.2))
        }

        XCTFail("Failed to focus text field within \(timeout)s. Last state: \(lastError ?? "unknown")")
    }

    @MainActor
    func testExample() throws {
        // Login first
        try loginToApp(login: primaryLogin, welcomeName: primaryWelcomeName)

        // Check that Log out button is displayed
        let logoutButton = app.buttons["Log out"]
        XCTAssertTrue(logoutButton.exists)
        logoutButton.tap()

        confirmLoginAlert(app)

        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 60))
    }

    @MainActor
    func testConfigurationResetButtonExists() throws {
        // Login first
        try loginToApp(login: primaryLogin, welcomeName: primaryWelcomeName)

        // Navigate to Home tab
        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.exists)
        homeTab.tap()

        // Check that Reset Configuration button exists
        let resetButton = app.buttons["Reset Configuration"]
        XCTAssertTrue(resetButton.exists, "Reset Configuration button should be visible after login")
    }

    @MainActor
    func testConfigurationResetAlertPresentation() throws {
        // Login first
        try loginToApp(login: primaryLogin, welcomeName: primaryWelcomeName)

        // Navigate to Home tab
        let homeTab = app.tabBars.buttons["Home"]
        homeTab.tap()

        // Tap Reset Configuration button
        let resetButton = app.buttons["Reset Configuration"]
        resetButton.tap()

        // Wait for alert and verify it has the expected options
        let alert = app.alerts.element
        XCTAssertTrue(alert.exists, "Configuration reset alert should appear")

        // Check for expected buttons in alert
        let switchAlternativeButton = alert.buttons["Switch to Alternative Tenant"]
        let switchPrimaryButton = alert.buttons["Switch to Primary Tenant"]
        let cancelButton = alert.buttons["Cancel"]

        XCTAssertTrue(switchAlternativeButton.exists, "Should have 'Switch to Alternative Tenant' button")
        XCTAssertTrue(switchPrimaryButton.exists, "Should have 'Switch to Primary Tenant' button")
        XCTAssertTrue(cancelButton.exists, "Should have 'Cancel' button")

        // Cancel the alert
        cancelButton.tap()

        // Verify alert is dismissed
        XCTAssertFalse(alert.exists, "Alert should be dismissed after canceling")
    }

    @MainActor
    func testConfigurationDisplayExists() throws {
        // Login first
        try loginToApp(login: primaryLogin, welcomeName: primaryWelcomeName)

        // Navigate to Home tab
        let homeTab = app.tabBars.buttons["Home"]
        homeTab.tap()

        // Check that configuration display text exists
        let configurationLabel = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Active Configuration'")).firstMatch
        XCTAssertTrue(configurationLabel.exists, "Active Configuration label should be displayed")
    }

    @MainActor
    func testConfigurationIndicatorInHeader() throws {
        // Login first
        try loginToApp(login: primaryLogin, welcomeName: primaryWelcomeName)

        // Check that the configuration indicator exists in the header
        let configIndicator = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Tenant:'")).firstMatch
        XCTAssertTrue(configIndicator.exists, "Configuration indicator should show tenant in header")
    }

    @MainActor
    func testAlertCancellationDoesNotChangeConfig() throws {
        // Login first
        try loginToApp(login: primaryLogin, welcomeName: primaryWelcomeName)

        // Navigate to Home tab
        let homeTab = app.tabBars.buttons["Home"]
        homeTab.tap()

        // Get the initial configuration text
        let configIndicators = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Tenant:'"))
        XCTAssertTrue(configIndicators.count > 0, "Should have at least one configuration indicator")
        let initialConfigText = configIndicators.firstMatch.label

        // Tap Reset Configuration button
        let resetButton = app.buttons["Reset Configuration"]
        resetButton.tap()

        // Cancel the alert
        let alert = app.alerts.element
        let cancelButton = alert.buttons["Cancel"]
        cancelButton.tap()

        // Verify configuration hasn't changed
        let finalConfigIndicators = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Tenant:'"))
        XCTAssertTrue(finalConfigIndicators.count > 0)
        let finalConfigText = finalConfigIndicators.firstMatch.label

        XCTAssertEqual(initialConfigText, finalConfigText, "Configuration should not change when alert is canceled")
    }

    // MARK: - New End to End Test

    @MainActor
    func testSwitchToAlternateConfigAndLogin() throws {
        // Login first
        try loginToApp(login: primaryLogin, welcomeName: primaryWelcomeName)

        // Navigate to Home tab
        let homeTab = app.tabBars.buttons["Home"]
        homeTab.tap()

        // Tap "Reset Configuration"
        let resetButton = app.buttons["Reset Configuration"]
        XCTAssertTrue(waitUntilHittable(resetButton, timeout: 15), "Reset Configuration button should be hittable")
        resetButton.tap()

        // Tap "Switch to Alternative Tenant" in alert
        let alert = app.alerts.element
        XCTAssertTrue(alert.waitForExistence(timeout: 10), "Configuration reset alert should appear")
        let switchAlternativeButton = alert.buttons["Switch to Alternative Tenant"]
        XCTAssertTrue(switchAlternativeButton.exists, "Should have 'Switch to Alternative Tenant' button")
        switchAlternativeButton.tap()

        var loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 60))

        // Proceed to Login to the alternate tenant
        try loginToApp(login: alternateLogin, welcomeName: alternateWelcomeName)

        // Check that Log out button is displayed
        let logoutButton = app.buttons["Log out"]
        XCTAssertTrue(logoutButton.exists)
        logoutButton.tap()

        confirmLoginAlert(app)

        // Proceed to Login to the primary tenant
        loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.waitForExistence(timeout: 60))
        loginButton.tap()

        confirmLoginAlert(app)
    }

    // MARK: - Helper Methods

    private func loginToApp(login: String, welcomeName: String) throws {
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()

        confirmLoginAlert(app)

        // Match Login field with any of these identifiers
        let loginField = app.textFields.matching(
            NSPredicate(format: "placeholderValue IN %@", ["Login", "Email"])
        ).firstMatch

        let passwordField = app.secureTextFields["Password"]
        let submitButton = app.buttons["Submit"]

        XCTAssertTrue(loginField.waitForExistence(timeout: 60))
        XCTAssertTrue(waitUntilHittable(loginField, timeout: 60))

        XCTAssertTrue(passwordField.waitForExistence(timeout: 60))
        XCTAssertTrue(waitUntilHittable(passwordField, timeout: 60))

        XCTAssertTrue(submitButton.waitForExistence(timeout: 60))
        XCTAssertTrue(waitUntilHittable(submitButton, timeout: 60))

        focusTextField(loginField)
        loginField.typeText(login)

        focusTextField(passwordField)
        passwordField.typeText("password\n")

        // dismiss the password prompt if it appears
        dismissPasswordSavePrompt(app)

        // Primary path: rely on Return to submit. Give the UI a brief grace period to transition.
        let welcomeText = app.staticTexts["Welcome " + welcomeName]
        let graceDeadline = Date().addingTimeInterval(1.0)
        while Date() < graceDeadline {
            if welcomeText.exists { break }
            RunLoop.current.run(until: Date().addingTimeInterval(0.15))
        }

        // Fallback: if we're clearly still on the login screen, tap Submit once.
        if !welcomeText.exists {
            let stillOnLoginScreen = loginField.exists && loginField.isHittable && passwordField.exists && passwordField.isHittable
            if stillOnLoginScreen && submitButton.exists && submitButton.isHittable {
                submitButton.tap()
            }
        }

        // Finally, ensure we reach the post-login state.
        XCTAssertTrue(welcomeText.waitForExistence(timeout: 60))
    }
}
