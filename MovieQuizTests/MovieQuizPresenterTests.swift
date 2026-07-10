//
//  MovieQuizPresenterTests.swift
//  MovieQuizTests
//
//  Created by Ринат Чембулатов on 08.07.2026.
//

import XCTest
@testable import MovieQuiz

class DummyViewController: MovieQuizViewControllerProtocol {
    func show(quiz step: QuizStepViewModel) {}
    func showResultsAlert(message: String) {}
    func highlightImageBorder(isCorrectAnswer: Bool) {}
    func showLoadingIndicator() {}
    func hideLoadingIndicator() {}
    func showNetworkError(message: String) {}
}

final class MovieQuizPresenterTests: XCTestCase {
    
    func testConvertModel() {
        let dummyVC = DummyViewController()
        let presenter = MovieQuizPresenter(viewController: dummyVC)
        
        let testImageData = Data([0x00, 0xFF])
        let question = QuizQuestion(image: testImageData, text: "Какой фильм вышел в 1999?", correctAnswer: true)
        
        let viewModel = presenter.convert(model: question)
        
        XCTAssertEqual(viewModel.image, testImageData, "Картинка должна совпадать")
        XCTAssertEqual(viewModel.question, "Какой фильм вышел в 1999?", "Текст вопроса должен совпадать")
        XCTAssertEqual(viewModel.questionNumber, "1/10", "Номер вопроса должен быть 1/10 (индекс 0 + 1)")
    }
}
