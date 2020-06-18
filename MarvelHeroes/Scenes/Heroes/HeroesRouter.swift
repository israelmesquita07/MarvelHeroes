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
    var dataStore: HeroesDataStore? { get }
}

final class HeroesRouter: NSObject, HeroesRoutingLogic, HeroesDataPassing {
    
    weak var viewController: HeroesViewController?
    var dataStore: HeroesDataStore?

    // MARK: - Routing
    
    func routeToDetails() {
        let destinationVC = HeroDetailsViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetails(source: dataStore!, destination: &destinationDS)
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
