//
//  GameResult.swift
//  MovieQuiz
//
//  Created by Ринат Чембулатов on 16.06.2026.
//

import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date
    
 
    func isBetter(than other: GameResult) -> Bool {
        return correct > other.correct
    }
}
