//
//  FavoriteHeroesFactory.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Mesquita on 16/03/21.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

final class FavoriteHeroesFactory {
    static func makeFavoriteHeroesViewController() -> UIViewController {
        let viewController = FavoriteHeroesViewController()
        let presenter = FavoriteHeroesPresenter(viewController: viewController)
        let interactor = FavoriteHeroesInteractor(presenter: presenter)
        viewController.setup(interactor: interactor)
        return viewController
    }
}
