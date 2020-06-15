//
//  HeroDetailsViewController.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsDisplayLogic: class {
    func displayHeroImage(viewModel: HeroDetails.Hero.ViewModel)
    func displayError(errorDescription: String)
}

final class HeroDetailsViewController: UIViewController {
    
    var interactor: HeroDetailsBusinessLogic?
    var router: (NSObjectProtocol & HeroDetailsDataPassing)?
    lazy var viewScreen = HeroDetailsViewScreen()
    
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
        let request = HeroDetails.Hero.Request()
        interactor?.loadHeroImage(request: request)
    }
}

//MARK: - HeroDetailsDisplayLogic
extension HeroDetailsViewController: HeroDetailsDisplayLogic {
    func displayHeroImage(viewModel: HeroDetails.Hero.ViewModel) {
        viewScreen.heroImageView.image = viewModel.imageHero
        viewScreen.heroLabel.text = viewModel.heroDescription
    }
    
    func displayError(errorDescription: String) {
        
    }
}
