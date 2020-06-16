//
//  HeroDetailsRouter.swift
//  MarvelHeroes
//
//  Created by Israel on 15/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsDataPassing {
    var dataStore: HeroDetailsDataStore? { get }
}

final class HeroDetailsRouter: NSObject, HeroDetailsDataPassing {
    weak var viewController: HeroDetailsViewController?
    var dataStore: HeroDetailsDataStore?
}
