//
//  HeroesViewControllerSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 17/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class HeroesViewControllerSpy {
    
    var displayHeroesCalled : Bool
    var displayErrorCalled : Bool
    var displayAlertErrorCalled : Bool
    var toggleLoadingCalled : Bool
    
    init() {
        displayHeroesCalled = false
        displayErrorCalled = false
        displayAlertErrorCalled = false
        toggleLoadingCalled = false
    }
}

//MARK: - HeroesDisplayLogic
extension HeroesViewControllerSpy: HeroesDisplayLogic {
    func displayHeroes(viewModel: Heroes.List.ViewModel) {
        displayHeroesCalled = true
    }
    
    func displayError(errorDescription: String) {
        displayErrorCalled = true
    }
    
    func displayAlertError(errorDescription: String) {
        displayAlertErrorCalled = true
    }
    
    func toggleLoading(_ bool: Bool) {
        toggleLoadingCalled = true
    }
}
