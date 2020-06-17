//
//  FavoriteHeroesViewController.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol FavoriteHeroesDisplayLogic: class {
    func displayFavoriteHeroes(viewModel: FavoriteHeroes.List.ViewModel)
    func displayError(errorDescription: String)
    func toggleLoading(_ bool: Bool)
}

final class FavoriteHeroesViewController: UIViewController {
    
    var interactor: FavoriteHeroesBusinessLogic?
    
    // MARK: - Setup
    
    private func setup() {
        let interactor = FavoriteHeroesInteractor()
        let presenter = FavoriteHeroesPresenter()
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadFavoriteHeroes()
        view.backgroundColor = .blue
    }
    
    // MARK: - Load Favorite Heroes
    
    func loadFavoriteHeroes() {
        let request = FavoriteHeroes.List.Request()
        interactor?.loadFavoriteHeroes(request: request)
    }
}

//MARK: - FavoriteHeroesDisplayLogic
extension FavoriteHeroesViewController: FavoriteHeroesDisplayLogic {
    func displayFavoriteHeroes(viewModel: FavoriteHeroes.List.ViewModel) {
        
    }
    
    func displayError(errorDescription: String) {
        
    }
    
    func toggleLoading(_ bool: Bool) {
        
    }
}
