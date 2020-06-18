//
//  HeroDetailsPresenterSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class HeroDetailsPresenterSpy {
    var presentHeroDetailsCalled : Bool
    var presentErrorCalled : Bool
    var presentAlertErrorCalled : Bool
    
    init() {
        presentHeroDetailsCalled = false
        presentErrorCalled = false
        presentAlertErrorCalled = false
    }
}

//MARK: - HeroDetailsPresentationLogic
extension HeroDetailsPresenterSpy: HeroDetailsPresentationLogic {
    func presentHeroImage(response: HeroDetails.Details.Response) {
        presentHeroDetailsCalled = true
    }
    
    func presentError(errorDescription: String) {
        presentErrorCalled = true
    }
    
    func presentAlertError(errorDescription: String) {
        presentAlertErrorCalled = true
    }
}
