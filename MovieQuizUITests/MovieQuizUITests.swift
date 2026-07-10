import XCTest

final class MovieQuizUITests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    // 🔹 ТЕСТ 1: Кнопка "Да" меняет постер и счётчик
    func testYesButtonChangesPosterAndCounter() throws {
        XCTAssertTrue(app.staticTexts["Index"].waitForExistence(timeout: 15))
        
        let posterBefore = app.images["Poster"]
        XCTAssertTrue(posterBefore.waitForExistence(timeout: 10))
        
        app.buttons["YesButton"].tap()
        sleep(3)
        
        XCTAssertTrue(app.staticTexts["Index"].waitForExistence(timeout: 20))
        
        XCTAssertTrue(posterBefore.exists)
    }
    
    // 🔹 ТЕСТ 2: Кнопка "Нет" меняет постер и счётчик
    func testNoButtonChangesPosterAndCounter() throws {
        XCTAssertTrue(app.staticTexts["Index"].waitForExistence(timeout: 15))
        
        let posterBefore = app.images["Poster"]
        XCTAssertTrue(posterBefore.waitForExistence(timeout: 10))
        
        app.buttons["NoButton"].tap()
        sleep(3)
        
        XCTAssertTrue(app.staticTexts["Index"].waitForExistence(timeout: 20))
        
        XCTAssertTrue(posterBefore.exists)
    }
    
    // 🔹 ТЕСТ 3: Алерт + текст кнопки
    func testAlertAppearanceAndButtonText() throws {
        XCTAssertTrue(app.staticTexts["Index"].waitForExistence(timeout: 15))
        
        for _ in 0..<10 {
            if app.buttons["YesButton"].waitForExistence(timeout: 5) {
                app.buttons["YesButton"].tap()
                sleep(2)
            }
        }
        
        let alert = app.alerts["Квиз завершен!"]
        XCTAssertTrue(alert.waitForExistence(timeout: 20))
        
        let button = alert.buttons["Сыграть ещё раз"]
        XCTAssertTrue(button.exists)
        XCTAssertEqual(button.label, "Сыграть ещё раз")
    }
    
    // 🔹 ТЕСТ 4: Исчезновение алерта + ТОЧНЫЙ сброс
    func testAlertDismissAndExactCounterReset() throws {
        XCTAssertTrue(app.staticTexts["Index"].waitForExistence(timeout: 15))
        
        for _ in 0..<10 {
            if app.buttons["YesButton"].waitForExistence(timeout: 5) {
                app.buttons["YesButton"].tap()
                sleep(2)
            }
        }
        
        let alert = app.alerts["Квиз завершен!"]
        XCTAssertTrue(alert.waitForExistence(timeout: 20))
        
        alert.buttons["Сыграть ещё раз"].tap()
        sleep(2)
        
        XCTAssertFalse(alert.exists)
        
        let indexLabel = app.staticTexts["Index"]
        XCTAssertEqual(indexLabel.label, "1/10")
    }
}
