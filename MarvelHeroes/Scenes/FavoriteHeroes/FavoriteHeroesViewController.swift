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
    private lazy var viewScreen = FavoriteHeroesViewScreen()
    private var errorView: ErrorView?
    
    // MARK: - Setup
    
    func setup(interactor: FavoriteHeroesBusinessLogic) {
        self.interactor = interactor
    }
    
    // MARK: - View lifecycle
    
    override func loadView() {
        view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorView?.removeFromSuperview()
        loadFavoriteHeroes()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        title = NSLocalizedString("favorites_title", comment: String())
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        navBar?.tintColor = .white
        navBar?.barStyle = .black
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
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
