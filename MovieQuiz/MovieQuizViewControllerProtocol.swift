//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Ринат Чембулатов on 08.07.2026.
//

import Foundation

protocol MovieQuizViewControllerProtocol: AnyObject {
    func show(quiz step: QuizStepViewModel)
    func showResultsAlert(message: String)
    func highlightImageBorder(isCorrectAnswer: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showNetworkError(message: String)
}
