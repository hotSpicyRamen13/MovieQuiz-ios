//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Ринат Чембулатов on 13.06.2026.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    
    func didReceiveNextQuestion(question: QuizQuestion?)
    
    func didLoadDataFromServer()
    
    func didFailToLoadData(with error: Error)
    
}

