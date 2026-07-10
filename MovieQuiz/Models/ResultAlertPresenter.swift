//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Ринат Чембулатов on 13.06.2026.
//


import UIKit

final class AlertPresenter {
    func show(in vc: UIViewController, model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        
        alert.addAction(action)
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = model.title
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
