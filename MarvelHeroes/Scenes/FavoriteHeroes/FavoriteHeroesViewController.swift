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
}

final class FavoriteHeroesViewController: UIViewController {
    
    var interactor: FavoriteHeroesBusinessLogic?
    lazy var viewScreen = FavoriteHeroesViewScreen()
    var errorView: ErrorView?
    
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
        setupView()

        loadFavoriteHeroes()
        view.backgroundColor = .blue
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        title = "Heróis Favoritos"
        view.backgroundColor = .white
        setupViewScreen()
    }
    
    private func setupViewScreen() {
        viewScreen.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewScreen)
        NSLayoutConstraint.activate([
            viewScreen.topAnchor.constraint(equalTo: view.topAnchor),
            viewScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Load Favorite Heroes
    
    private func loadFavoriteHeroes() {
        let request = FavoriteHeroes.List.Request()
        interactor?.loadFavoriteHeroes(request: request)
    }
    
    private func showErrorView() {
        guard let errorView = errorView else { return }
        errorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorView)
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - FavoriteHeroesDisplayLogic
extension FavoriteHeroesViewController: FavoriteHeroesDisplayLogic {
    func displayFavoriteHeroes(viewModel: FavoriteHeroes.List.ViewModel) {
        viewScreen.favoriteHeroes = viewModel.heroes
    }
    
    func displayError(errorDescription: String) {
        errorView = ErrorView(delegate: self, errorText: errorDescription)
        showErrorView()
    }
}

//MARK: - ErrorViewHeroesReloading
extension FavoriteHeroesViewController: ErrorViewHeroesReloading {
    func tryAgain() {
        errorView?.removeFromSuperview()
        loadFavoriteHeroes()
    }
}
