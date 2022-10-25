//
//  AlertPresentable.swift
//  CocoaHeads2022
//
//  Created by user on 24/10/22.
//

import UIKit

protocol AlertPresentable { }

struct AlertViewModel {
    let title: String
    let message: String?
    let actionTitle: String
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(with viewModel: AlertViewModel) {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: viewModel.actionTitle, style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
