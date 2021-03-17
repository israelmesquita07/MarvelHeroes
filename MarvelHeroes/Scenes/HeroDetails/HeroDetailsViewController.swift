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
    
    var router: HeroDetailsDataPassing?
    var interactor: HeroDetailsBusinessLogic?
    private var errorView: ErrorView?
    private lazy var viewScreen = HeroDetailsViewScreen(delegate: self)
    
    // MARK: - Setup
    
    func setup(interactor: HeroDetailsBusinessLogic, router: HeroDetailsDataPassing) {
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
        loadHeroImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorView?.removeFromSuperview()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        title = NSLocalizedString("details_title", comment: String())
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Load Hero Image
    
    func loadHeroImage() {
        let request = HeroDetails.Details.Request()
        interactor?.loadHeroImage(request: request)
    }
    
    private func showAlertMessage(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("alert_error_title", comment: String()), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("alert_error_default_action", comment: String()), style: .default, handler: nil))
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
