//
//  HeroesPresenterSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 17/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class HeroesPresenterSpy {
    var presentHeroesCalled : Bool
    var presentErrorCalled : Bool
    var presentAlertErrorCalled : Bool
    var toggleLoadingCalled : Bool
    
    init() {
        presentHeroesCalled = false
        presentErrorCalled = false
        presentAlertErrorCalled = false
        toggleLoadingCalled = false
    }
}

//MARK: - HeroesPresentationLogic
extension HeroesPresenterSpy: HeroesPresentationLogic {
    func presentHeroes(response: Heroes.List.Response) {
        presentHeroesCalled = true
    }
    
    func presentError(errorDescription: String) {
        presentErrorCalled = true
    }
    
    func presentAlertError(errorDescription: String) {
        presentAlertErrorCalled = true
    }
    
    func toggleLoading(_ bool: Bool) {
        toggleLoadingCalled = true
    }
}
