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
    func displayError()
}

final class Presenter {
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
                self.view?.display(with: Presenter.makeViewModel(with: name))
            case .failure:
                self.view?.displayError()
            }
        }
    }
    
    // MARK: - Private Methods
    
    static func makeViewModel(with name: String) -> ViewModel {
        .init(description: "Olá, \(name)")
    }
}
