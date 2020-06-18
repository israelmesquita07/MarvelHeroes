//
//  HeroDetailsViewControllerSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class HeroDetailsViewControllerSpy {
    var displayHeroImageCalled : Bool
    var displayAlertErrorCalled : Bool
    var displayErrorCalled : Bool
    
    init() {
        displayHeroImageCalled = false
        displayAlertErrorCalled = false
        displayErrorCalled = false
    }
}


//MARK: - HeroDetailsDisplayLogic
extension HeroDetailsViewControllerSpy: HeroDetailsDisplayLogic {
    func displayHeroImage(viewModel: HeroDetails.Details.ViewModel) {
        displayHeroImageCalled = true
    }
    
    func displayAlertError(errorDescription: String) {
        displayAlertErrorCalled = true
    }
    
    func displayError(errorDescription: String) {
        displayErrorCalled = true
    }
}
