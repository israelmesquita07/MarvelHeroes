//
//  HeroDetailsPresenter.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsPresentationLogic {
    func presentHeroDetails(response: HeroDetails.Hero.Response)
    func presentError(errorDescription: String)
}

final class HeroDetailsPresenter: HeroDetailsPresentationLogic {
    
    weak var viewController: HeroDetailsDisplayLogic?
    
    // MARK: - Present Hero Details
    
    func presentHeroDetails(response: HeroDetails.Hero.Response) {
        let viewModel = HeroDetails.Hero.ViewModel(imageHero: response.imageHero, heroDescription: response.heroDescription)
        viewController?.displayHeroImage(viewModel: viewModel)
    }
    
    // MARK: - Present Error
    
    func presentError(errorDescription: String) {
        viewController?.displayError(errorDescription: errorDescription)
    }
}
