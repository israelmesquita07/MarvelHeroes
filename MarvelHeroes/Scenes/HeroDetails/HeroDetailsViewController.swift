//
//  HeroDetailsViewController.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsDisplayLogic: class {
    func displayHeroImage(viewModel: HeroDetails.Details.ViewModel)
    func displayAlertError(errorDescription: String)
    func displayError(errorDescription: String)
}

final class HeroDetailsViewController: UIViewController {
    
    var interactor: HeroDetailsBusinessLogic?
    var router: (NSObjectProtocol & HeroDetailsDataPassing)?
    var errorView: ErrorView?
    lazy var viewScreen = HeroDetailsViewScreen(delegate: self)
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let interactor = HeroDetailsInteractor()
        let presenter = HeroDetailsPresenter()
        let router = HeroDetailsRouter()
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
        setupView()
        loadHeroImage()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        title = "Herói Marvel"
        navigationController?.navigationBar.prefersLargeTitles = false
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
    
    // MARK: - Load Hero Image
    
    func loadHeroImage() {
        let request = HeroDetails.Details.Request()
        interactor?.loadHeroImage(request: request)
    }
    
    private func showAlertMessage(message: String) {
        let alert = UIAlertController(title: "Ops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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

//MARK: - HeroDetailsDisplayLogic
extension HeroDetailsViewController: HeroDetailsDisplayLogic {
    func displayHeroImage(viewModel: HeroDetails.Details.ViewModel) {
        viewScreen.setupViewScreen(viewModel.imageHero, viewModel.hero)
    }
    
    func displayAlertError(errorDescription: String) {
        showAlertMessage(message: errorDescription)
    }
    
    func displayError(errorDescription: String) {
        errorView = ErrorView(delegate: self, errorText: errorDescription)
        showErrorView()
    }
}


//MARK: - HeroDetailsViewScreenDelegating
extension HeroDetailsViewController: HeroDetailsViewScreenDelegating {
    func markAsFavorite(heroData: HeroData) -> Bool {
        interactor?.markAsFavorite(heroData: heroData) ?? false
    }
    
    func deleteHeroData(heroId: Int) -> Bool {
        interactor?.deleteHeroData(heroId: heroId) ?? true
    }
}

//MARK: - ErrorViewHeroesReloading
extension HeroDetailsViewController: ErrorViewHeroesReloading {
    func tryAgain() {
        errorView?.removeFromSuperview()
        loadHeroImage()
    }
}
