//
//  HeroDetailsInteractor.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsBusinessLogic {
    func loadHeroImage(request: HeroDetails.Hero.Request)
}

protocol HeroDetailsDataStore {
    var hero: Hero? { get set }
}

final class HeroDetailsInteractor: HeroDetailsBusinessLogic, HeroDetailsDataStore {
    
    var presenter: HeroDetailsPresentationLogic?
    var hero: Hero?
    var worker: FetchHeroImageServicing?
    
    // MARK: - Load Hero Image
    
    func loadHeroImage(request: HeroDetails.Hero.Request) {
        worker = worker ?? HeroDetailsWorker()
        guard let url = hero?.thumbnail.url, let description = hero?.description else {
            return
        }
        worker?.fetchHeroImage(url: url) { result in
            switch result {
            case .success(let image):
                let response = HeroDetails.Hero.Response(imageHero: image, heroDescription: description)
                self.presenter?.presentHeroDetails(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
