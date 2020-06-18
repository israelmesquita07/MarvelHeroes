//
//  HeroDetailsWorkerSpy.swift
//  MarvelHeroesTests
//
//  Created by Israel on 18/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit
@testable import MarvelHeroes

final class HeroDetailsWorkerSpy {
    var fetchHeroImageCalled : Bool
    
    init() {
        fetchHeroImageCalled = false
    }
}

//MARK: - ListHeroesServicing
extension HeroDetailsWorkerSpy: FetchHeroImageServicing {
    func fetchHeroImage(url: String, completion: @escaping (Result<UIImage, HeroesError>) -> Void) {
        fetchHeroImageCalled = true
    }
}
