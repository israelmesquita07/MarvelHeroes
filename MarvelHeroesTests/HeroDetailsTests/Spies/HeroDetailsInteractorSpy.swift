//
//  HeroDetailsInteractorSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class HeroDetailsInteractorSpy {
    var loadHeroImageCalled : Bool
    var markAsFavoriteCalled : Bool
    var deleteHeroDataCalled : Bool
    
    init() {
        loadHeroImageCalled = false
        markAsFavoriteCalled = false
        deleteHeroDataCalled = false
    }
}

//MARK: - HeroDetailsBusinessLogic
extension HeroDetailsInteractorSpy: HeroDetailsBusinessLogic {
    func loadHeroImage(request: HeroDetails.Details.Request) {
        loadHeroImageCalled = true
    }
    
    func markAsFavorite(heroData: HeroData) -> Bool {
        markAsFavoriteCalled = true
        return false
    }
    
    func deleteHeroData(heroId: Int) -> Bool {
        deleteHeroDataCalled = true
        return false
    }
}
