//
//  Factory.swift
//  CocoaHeads2022
//
//  Created by user on 24/10/22.
//

import UIKit

enum Factory {
    static func make() -> UIViewController {
        let loader = LoadNameFromRemote()
        let presenter = Presenter(loader: loader)
        let viewController = ViewController(presenter: presenter)
        presenter.view = viewController
        return UINavigationController(rootViewController: viewController)
    }
}
