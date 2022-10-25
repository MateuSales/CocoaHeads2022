//
//  ViewController.swift
//  CocoaHeads2022
//
//  Created by user on 24/10/22.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.style = UIActivityIndicatorView.Style.medium
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addViewsInHierarchy()
        setupConstraints()
        
        loadingView.startAnimating()
        API.shared.request(url: .init(string: "http://any-url")!) { [weak self] name in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            guard let name = name else {
                self.showError()
                return
            }

            self.nameLabel.text = "Olá, \(name)"
        }
    }
}

// MARK: - Private Methods

private extension ViewController {
    func showError() {
        let alert = UIAlertController(
            title: "Tivemos um problema :(",
            message: "Tente novamente mais tarde",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - Setup Views

private extension ViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        title = "CocoaHeads"
    }
    
    func addViewsInHierarchy() {
        view.addSubview(nameLabel)
        view.addSubview(loadingView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
             loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
    }
}
