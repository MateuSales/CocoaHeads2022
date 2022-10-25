//
//  Presenter.swift
//  CocoaHeads2022
//
//  Created by user on 24/10/22.
//

import Foundation

struct ViewModel {
    let description: String
}

protocol PresenterOutput: AnyObject {
    func startLoading()
    func stopLoading()
    func display(with viewModel: ViewModel)
    func displayError(with viewModel: AlertViewModel)
}

protocol PresenterInput: AnyObject {
    func loadInitialState()
}

final class Presenter: PresenterInput {
    weak var view: PresenterOutput?
    private let loader: NameLoader
    
    init(loader: NameLoader) {
        self.loader = loader
    }

    func loadInitialState() {
        view?.startLoading()
        
        loader.load { [weak self] result in
            guard let self = self else { return }
            self.view?.stopLoading()
            switch result {
            case let .success(name):
                self.view?.display(with: self.makeViewModel(with: name))
            case .failure:
                self.view?.displayError(with: self.makeErrorViewModel())
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func makeViewModel(with name: String) -> ViewModel {
        .init(description: "Olá, \(name)")
    }
    
    private func makeErrorViewModel() -> AlertViewModel {
        .init(
            title: "Tivemos um problema",
            message: "Tente novamente mais tarde",
            actionTitle: "OK"
        )
    }
}
