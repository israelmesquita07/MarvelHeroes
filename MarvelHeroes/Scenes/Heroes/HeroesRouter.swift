//
//  HeroesRouter.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

@objc protocol HeroesRoutingLogic {
    func routeToDetails()
}

protocol HeroesDataPassing {
    var dataStore: HeroesDataStore { get }
}

final class HeroesRouter: HeroesRoutingLogic, HeroesDataPassing {
    
    weak var viewController: HeroesViewController?
    var dataStore: HeroesDataStore
    
    init(viewController: HeroesViewController?, dataStore: HeroesDataStore) {
        self.viewController = viewController
        self.dataStore = dataStore
    }

    // MARK: - Routing
    
    func routeToDetails() {
        let destinationVC = HeroDetailsFactory.makeHeroDetailsViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetails(source: dataStore, destination: &destinationDS)
        navigateToDetails(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToDetails(source: HeroesViewController,
                           destination: HeroDetailsViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    // MARK: Passing data

    func passDataToDetails(source: HeroesDataStore, destination: inout HeroDetailsDataStore) {
        destination.hero = source.hero
    }
}
