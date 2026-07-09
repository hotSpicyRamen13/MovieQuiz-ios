import XCTest

final class MovieQuizUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        addUIInterruptionMonitor(withDescription: "NetworkError") { alert -> Bool in
            if alert.buttons["Попробовать еще раз"].exists {
                alert.buttons["Попробовать еще раз"].tap()
                return true
            }
            return false
        }
        
        app.tap()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    // ТЕСТ 1: Кнопка "Да" меняет вопрос
    func testYesButtonChangesQuestion() throws {
        let predicate = NSPredicate(format: "label CONTAINS '/10'")
        XCTAssertTrue(app.staticTexts.matching(predicate).element.waitForExistence(timeout: 60))
        
        app.buttons["YesButton"].tap()
        sleep(4)
        
        let newPredicate = NSPredicate(format: "label CONTAINS '/10' AND label != '1/10'")
        XCTAssertTrue(app.staticTexts.matching(newPredicate).element.waitForExistence(timeout: 30))
    }
    
    // ТЕСТ 2: Кнопка "Нет" меняет вопрос
    func testNoButtonChangesQuestion() throws {
        let predicate = NSPredicate(format: "label CONTAINS '/10'")
        XCTAssertTrue(app.staticTexts.matching(predicate).element.waitForExistence(timeout: 60))
        
        app.buttons["NoButton"].tap()
        sleep(4)
        
        let newPredicate = NSPredicate(format: "label CONTAINS '/10' AND label != '1/10'")
        XCTAssertTrue(app.staticTexts.matching(newPredicate).element.waitForExistence(timeout: 30))
    }
    
    // ТЕСТ 3: Алерт появляется после окончания игры
    func testAlertAppearsAfterGame() throws {
        let predicate = NSPredicate(format: "label CONTAINS '/10'")
        XCTAssertTrue(app.staticTexts.matching(predicate).element.waitForExistence(timeout: 60))
        
        for _ in 0..<10 {
            app.buttons["YesButton"].tap()
            sleep(4)
        }
        
        let alert = app.alerts["Квиз завершен!"]
        XCTAssertTrue(alert.waitForExistence(timeout: 40))
    }
    
    // ТЕСТ 4: Алерт скрывается и счётчик сбрасывается
    func testAlertHidesAndCounterResets() throws {
        let predicate = NSPredicate(format: "label CONTAINS '/10'")
        XCTAssertTrue(app.staticTexts.matching(predicate).element.waitForExistence(timeout: 60))
        
        for _ in 0..<10 {
            app.buttons["YesButton"].tap()
            sleep(4)
        }
        
        let alert = app.alerts["Квиз завершен!"]
        XCTAssertTrue(alert.waitForExistence(timeout: 40))
        
        alert.buttons["Сыграть ещё раз"].tap()
        sleep(3)
        
        XCTAssertTrue(app.staticTexts.matching(predicate).element.waitForExistence(timeout: 30))
    }
}
