import XCTest

final class QuickstartTests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()

        continueAfterFailure = false

        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

    @MainActor
    func testExample() throws {
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

        XCTAssertTrue(waitUntilHittable(loginField, timeout: 60))
        XCTAssertTrue(waitUntilHittable(passwordField, timeout: 60))
        XCTAssertTrue(waitUntilHittable(submitButton, timeout: 60))

        loginField.tap()
        loginField.typeText("richard@example.com")

        // Tap the password field to focus it
        let frame = passwordField.frame
        let normalized = app.coordinate(withNormalizedOffset: .zero)
        let coordinate = normalized.withOffset(CGVector(dx: frame.midX, dy: frame.midY))
        coordinate.tap()
        
        //passwordField.tap()
        
        // Now type the password
        passwordField.typeText("password")
        passwordField.typeText("\n")

        // Check that Welcome message is displayed
        let welcomeText = app.staticTexts["Welcome Richard Hendricks"]

        XCTAssertTrue(welcomeText.waitForExistence(timeout: 60))

        // Check that Log out button is displayed
        let logoutButton = app.buttons["Log out"]
        XCTAssertTrue(logoutButton.exists)
        logoutButton.tap()

        confirmLoginAlert(app)

        XCTAssertTrue(loginButton.waitForExistence(timeout: 60))
    }
    
    func waitUntilHittable(_ element: XCUIElement, timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate(format: "exists == true AND hittable == true")
        let exp = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [exp], timeout: timeout)
        return result == .completed
    }
}
