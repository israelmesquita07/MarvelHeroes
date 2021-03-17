//
//  HeroesFactory.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Mesquita on 16/03/21.
//  Copyright © 2021 israel3D. All rights reserved.
//

import UIKit

final class HeroesFactory {
    static func makeNavigationController() -> UINavigationController {
        let viewController = HeroesViewController()
        let presenter = HeroesPresenter(viewController: viewController)
        let worker = HeroesWorker()
        let interactor = HeroesInteractor(presenter: presenter, worker: worker)
        let router = HeroesRouter(viewController: viewController, dataStore: interactor)
        viewController.setup(interactor: interactor, router: router)
        let navigationController = UINavigationController(rootViewController: viewController)
        let heroesViewController = navigationController
        heroesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return navigationController
    }
}
