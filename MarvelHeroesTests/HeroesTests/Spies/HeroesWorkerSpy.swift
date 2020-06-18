//
//  HeroesWorkerSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation
@testable import MarvelHeroes

final class HeroesWorkerSpy {
    var fetchHeroesCalled : Bool
    
    init() {
        fetchHeroesCalled = false
    }
}

//MARK: - ListHeroesServicing
extension HeroesWorkerSpy: ListHeroesServicing {
    func fetchHeroes(name: String, page: Int, completion: @escaping (Result<MarvelInfo, HeroesError>) -> Void) {
        fetchHeroesCalled = true
    }
}
