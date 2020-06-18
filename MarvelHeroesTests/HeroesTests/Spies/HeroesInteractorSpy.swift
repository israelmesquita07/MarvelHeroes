//
//  HeroesInteractorSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 17/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class HeroesInteractorSpy {
    var loadHeroesCalled : Bool
    var searchHeroesCalled : Bool
    var fillDataToDetailsCalled : Bool
    var markAsFavoriteCalled : Bool
    var deleteHeroDataCalled : Bool
    
    init() {
        loadHeroesCalled = false
        searchHeroesCalled = false
        fillDataToDetailsCalled = false
        markAsFavoriteCalled = false
        deleteHeroDataCalled = false
    }
}


//MARK: - HeroesBusinessLogic
extension HeroesInteractorSpy: HeroesBusinessLogic {
    func loadHeroes(request: Heroes.List.Request) {
        loadHeroesCalled = true
    }
    
    func searchHeroes(request: Heroes.List.Request) {
        searchHeroesCalled = true
    }
    
    func fillDataToDetails(hero: Hero) {
        fillDataToDetailsCalled = true
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
