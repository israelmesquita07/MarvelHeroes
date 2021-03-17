//
//  FavoriteHeroesPresenter.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol FavoriteHeroesPresentationLogic {
    func presentFavoriteHeroes(response: FavoriteHeroes.List.Response)
    func presentError(errorDescription: String)
}

final class FavoriteHeroesPresenter: FavoriteHeroesPresentationLogic {
    
    weak var viewController: FavoriteHeroesDisplayLogic?
    
    init(viewController: FavoriteHeroesDisplayLogic) {
        self.viewController = viewController
    }
    
    // MARK: Present Favorite Heroes
    
    func presentFavoriteHeroes(response: FavoriteHeroes.List.Response) {
        let viewModel = FavoriteHeroes.List.ViewModel(heroes: response.heroes)
        viewController?.displayFavoriteHeroes(viewModel: viewModel)
    }
    
    // MARK: - Present Error
    
    func presentError(errorDescription: String) {
        viewController?.displayError(errorDescription: errorDescription)
    }
}
