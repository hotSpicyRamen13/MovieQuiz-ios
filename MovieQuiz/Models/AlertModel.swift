//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Ринат Чембулатов on 13.06.2026.
//

import Foundation

struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completion: () -> Void
}
