//
//  FavoriteHeroesInteractor.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol FavoriteHeroesBusinessLogic {
    func loadFavoriteHeroes(request: FavoriteHeroes.List.Request)
}

final class FavoriteHeroesInteractor: FavoriteHeroesBusinessLogic {
    
    let presenter: FavoriteHeroesPresentationLogic
    
    init(presenter: FavoriteHeroesPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: Load Favorite Heroes
    
    func loadFavoriteHeroes(request: FavoriteHeroes.List.Request) {
        let heroes = fetchFavorites()
        if heroes.count > 0 {
            let response = FavoriteHeroes.List.Response(heroes: heroes)
            presenter.presentFavoriteHeroes(response: response)
            return
        }
        presenter.presentError(errorDescription: NSLocalizedString("error_not_found_favorite", comment: String()))
    }
    
    private func fetchFavorites() -> [HeroData] {
        DatabaseHelper.shareInstance.fetchHeroData() ?? []
    }
}
