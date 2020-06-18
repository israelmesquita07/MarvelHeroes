//
//  FavoriteHeroesViewControllerSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class FavoriteHeroesViewControllerSpy {
    var displayFavoriteHeroesCalled : Bool
    var displayErrorCalled : Bool
    
    init() {
        displayFavoriteHeroesCalled = false
        displayErrorCalled = false
    }
}


//MARK: - FavoriteHeroesDisplayLogic
extension FavoriteHeroesViewControllerSpy: FavoriteHeroesDisplayLogic {
    func displayFavoriteHeroes(viewModel: FavoriteHeroes.List.ViewModel) {
        displayFavoriteHeroesCalled = true
    }
    
    func displayError(errorDescription: String) {
        displayErrorCalled = true
    }
}
