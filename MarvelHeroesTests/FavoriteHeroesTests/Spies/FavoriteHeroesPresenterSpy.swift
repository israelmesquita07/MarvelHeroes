//
//  FavoriteHeroesPresenterSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class FavoriteHeroesPresenterSpy {
    var presentFavoriteHeroesCalled : Bool
    var presentErrorCalled : Bool
    
    init() {
        presentFavoriteHeroesCalled = false
        presentErrorCalled = false
    }
}


//MARK: - FavoriteHeroesPresentationLogic
extension FavoriteHeroesPresenterSpy: FavoriteHeroesPresentationLogic {
    func presentFavoriteHeroes(response: FavoriteHeroes.List.Response) {
        presentFavoriteHeroesCalled = true
    }
    
    func presentError(errorDescription: String) {
        presentErrorCalled = true
    }
}
