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
    
    private let presenter: PresenterInput
    
    init(presenter: PresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addViewsInHierarchy()
        setupConstraints()

        presenter.loadInitialState()
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

// MARK: - Presenter Output

extension ViewController: PresenterOutput {
    func startLoading() {
        loadingView.startAnimating()
    }
    
    func stopLoading() {
        loadingView.stopAnimating()
    }
    
    func display(with viewModel: ViewModel) {
        nameLabel.text = viewModel.description
    }
    
    func displayError() {
        showError()
    }
}
