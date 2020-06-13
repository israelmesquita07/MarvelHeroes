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
    func toggleLoading(_ bool: Bool)
}

final class HeroesViewController: UIViewController {
    
    var interactor: HeroesBusinessLogic?
    var router: (NSObjectProtocol & HeroesRoutingLogic & HeroesDataPassing)?
    
    // MARK: - Setup
    
    private func setup() {
        let interactor = HeroesInteractor()
        let presenter = HeroesPresenter()
        let router = HeroesRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadHeroes()
        view.backgroundColor = .red
    }
    
    // MARK: - Load Heroes
    
    func loadHeroes() {
        let request = Heroes.List.Request()
        interactor?.loadHeroes(request: request)
    }
}

//MARK: - HeroesDisplayLogic
extension HeroesViewController: HeroesDisplayLogic {
    func displayHeroes(viewModel: Heroes.List.ViewModel) {
        
    }
    
    func displayError(errorDescription: String) {
        
    }
    
    func toggleLoading(_ bool: Bool) {
        
    }
}
