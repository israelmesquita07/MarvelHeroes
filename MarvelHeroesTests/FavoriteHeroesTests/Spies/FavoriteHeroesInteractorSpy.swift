//
//  FavoriteHeroesInteractorSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class FavoriteHeroesInteractorSpy {
    var loadFavoriteHeroesCalled : Bool
    
    init() {
        loadFavoriteHeroesCalled = false
    }
}

//MARK: - FavoriteHeroesBusinessLogic
extension FavoriteHeroesInteractorSpy: FavoriteHeroesBusinessLogic {
    func loadFavoriteHeroes(request: FavoriteHeroes.List.Request) {
        loadFavoriteHeroesCalled = true
    }
}
