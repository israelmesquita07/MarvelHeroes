//
//  HeroDetailsPresenter.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsPresentationLogic {
    func presentHeroImage(response: HeroDetails.Details.Response)
    func presentError(errorDescription: String)
    func presentAlertError(errorDescription: String)
}

final class HeroDetailsPresenter: HeroDetailsPresentationLogic {
    
    private weak var viewController: HeroDetailsDisplayLogic?
    
    init(viewController: HeroDetailsDisplayLogic) {
        self.viewController = viewController
    }
    
    // MARK: - Present Hero Details
    
    func presentHeroImage(response: HeroDetails.Details.Response) {
        let viewModel = HeroDetails.Details.ViewModel(imageHero: response.imageHero, hero: response.hero)
        viewController?.displayHeroImage(viewModel: viewModel)
    }
    
    // MARK: - Present Error
    
    func presentError(errorDescription: String) {
        viewController?.displayError(errorDescription: errorDescription)
    }
    
    func presentAlertError(errorDescription: String) {
        viewController?.displayAlertError(errorDescription: errorDescription)
    }
}
