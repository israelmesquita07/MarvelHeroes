//
//  HeroesViewController.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroesDisplayLogic: class {
    func displayHeroes(viewModel: Heroes.List.ViewModel)
    func displayError(errorDescription: String)
    func displayAlertError(errorDescription: String)
    func toggleLoading(_ bool: Bool)
}

final class HeroesViewController: UIViewController {
    
    var interactor: HeroesBusinessLogic?
    var router: HeroesRoutingLogic?
    private var errorView: ErrorView?
    private lazy var viewScreen = HeroesViewScreen(delegate: self)
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.barStyle = .black
        return searchBar
    }()
    
    // MARK: - Setup
    
    func setup(interactor: HeroesBusinessLogic, router: HeroesRoutingLogic) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - View lifecycle
    
    override func loadView() {
        view = viewScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadHeroes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorView?.removeFromSuperview()
        viewScreen.reloadData()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        navBar?.tintColor = .white
        navBar?.barStyle = .black
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = NSLocalizedString("heroes_title", comment: String())
        showSearchBarButton(true)
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
    
    // MARK: - Load Heroes
    
    private func loadHeroes(heroName: String = String()) {
        let request = Heroes.List.Request(heroName: heroName)
        interactor?.loadHeroes(request: request)
    }
    
    private func searchHeroes(heroName: String) {
        let request = Heroes.List.Request(heroName: heroName)
        interactor?.searchHeroes(request: request)
    }
    
    private func showSearchBarButton(_ bool: Bool) {
        if bool {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func search(shouldShow: Bool) {
        showSearchBarButton(!shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    @objc private func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    private func showAlertMessage(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("alert_error_title", comment: String()), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("alert_error_default_action", comment: String()), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - HeroesDisplayLogic
extension HeroesViewController: HeroesDisplayLogic {
    func displayHeroes(viewModel: Heroes.List.ViewModel) {
        viewScreen.heroes = viewModel.heroes
    }
    
    func displayError(errorDescription: String) {
        errorView = ErrorView(delegate: self, errorText: errorDescription)
        showErrorView()
    }
    
    func displayAlertError(errorDescription: String) {
        showAlertMessage(message: errorDescription)
    }
    
    func toggleLoading(_ bool: Bool) {
        bool ? viewScreen.startLoading() : viewScreen.stopLoading()
    }
}

//MARK: - ViewScreenDelegating
extension HeroesViewController: ViewScreenDelegating {
    func didSelectRowAt(hero: Hero) {
        interactor?.fillDataToDetails(hero: hero)
        router?.routeToDetails()
    }
    
    func notifyTableViewEnds() {
        loadHeroes(heroName: searchBar.text ?? String())
    }
    
    func refreshItems() {
        searchHeroes(heroName: searchBar.text ?? String())
    }
    
    func markAsFavorite(heroData: HeroData) -> Bool {
        interactor?.markAsFavorite(heroData: heroData) ?? false
    }
    
    func deleteHeroData(heroId: Int) -> Bool {
        interactor?.deleteHeroData(heroId: heroId) ?? true
    }
}

//MARK: - UISearchBarDelegate
extension HeroesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        searchHeroes(heroName: String())
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchHeroes(heroName: searchBar.text ?? String())
        searchBar.resignFirstResponder()
    }
}

//MARK: - ErrorViewHeroesReloading
extension HeroesViewController: ErrorViewHeroesReloading {
    func tryAgain() {
        errorView?.removeFromSuperview()
        loadHeroes()
    }
}
