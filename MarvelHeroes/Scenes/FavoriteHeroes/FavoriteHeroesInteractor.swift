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

class FavoriteHeroesInteractor: FavoriteHeroesBusinessLogic {
    
    var presenter: FavoriteHeroesPresentationLogic?
    var worker: ListFavoriteHeroesServicing?
    
    // MARK: Load Favorite Heroes
    
    func loadFavoriteHeroes(request: FavoriteHeroes.List.Request) {
        worker = worker ?? FavoriteHeroesWorker()
        worker?.fetchFavoriteHeroes()
        
        let response = FavoriteHeroes.List.Response()
        presenter?.presentFavoriteHeroes(response: response)
    }
}
