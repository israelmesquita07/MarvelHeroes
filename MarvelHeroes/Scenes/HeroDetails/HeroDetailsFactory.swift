//
//  HeroDetailsFactory.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Mesquita on 16/03/21.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

final class HeroDetailsFactory {
    static func makeHeroDetailsViewController() -> HeroDetailsViewController {
        let viewController = HeroDetailsViewController()
        let worker = HeroDetailsWorker()
        let presenter = HeroDetailsPresenter(viewController: viewController)
        let interactor = HeroDetailsInteractor(presenter: presenter, worker: worker)
        let router = HeroDetailsRouter(viewController: viewController, dataStore: interactor)
        viewController.setup(interactor: interactor, router: router)
        return viewController
    }
}
