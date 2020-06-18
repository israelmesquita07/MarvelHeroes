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
    var router: (NSObjectProtocol & HeroesRoutingLogic & HeroesDataPassing)?
    var errorView: ErrorView?
    lazy var viewScreen = HeroesViewScreen(delegate: self)
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.barStyle = .black
        return searchBar
    }()
    
    // MARK: - Setup
    
    private func setup() {
        let interactor = HeroesInteractor()
        let presenter = HeroesPresenter()
        let router = HeroesRouter()
        self.interactor = interactor
        self.router = router
        presenter.viewController = self
        interactor.presenter = presenter
        router.viewController = self
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupView()
        setupNavigation()
        loadHeroes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorView?.removeFromSuperview()
        viewScreen.reloadData()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        title = "Heróis Marvel"
        view.backgroundColor = .white
        setupViewScreen()
    }
    
    private func setupNavigation() {
        let navBar = navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
        navBar?.tintColor = .white
        navBar?.barStyle = .black
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        showSearchBarButton(true)
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
    
    private func loadHeroes(heroName: String = "") {
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
        let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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
        if bool {
            viewScreen.startLoading()
            return
        }
        viewScreen.stopLoading()
    }
}

//MARK: - ViewScreenDelegating
extension HeroesViewController: ViewScreenDelegating {
    func didSelectRowAt(hero: Hero) {
        interactor?.fillDataToDetails(hero: hero)
        router?.routeToDetails()
    }
    
    func notifyTableViewEnds() {
        loadHeroes(heroName: searchBar.text ?? "")
    }
    
    func refreshItems() {
        searchHeroes(heroName: searchBar.text ?? "")
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
        searchHeroes(heroName: "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchHeroes(heroName: searchBar.text ?? "")
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
