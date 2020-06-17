//
//  HeroDetailsInteractor.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroDetailsBusinessLogic {
    func loadHeroImage(request: HeroDetails.Details.Request)
    func markAsFavorite(heroData: HeroData) -> Bool
    func deleteHeroData(heroId: Int) -> Bool
}

protocol HeroDetailsDataStore {
    var hero: Hero? { get set }
}

final class HeroDetailsInteractor: HeroDetailsBusinessLogic, HeroDetailsDataStore {
    
    var presenter: HeroDetailsPresentationLogic?
    var hero: Hero?
    var worker: FetchHeroImageServicing?
    
    // MARK: - Load Hero Image
    
    func loadHeroImage(request: HeroDetails.Details.Request) {
        worker = worker ?? HeroDetailsWorker()
        guard let url = hero?.thumbnail.url, let hero = hero else {
            return
        }
        worker?.fetchHeroImage(url: url) { result in
            switch result {
            case .success(let image):
                let response = HeroDetails.Details.Response(imageHero: image, hero: hero)
                self.presenter?.presentHeroDetails(response: response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Core Data
    
    func markAsFavorite(heroData: HeroData) -> Bool {
        if DatabaseHelper.shareInstance.saveHeroData(data: heroData) {
            return true
        } else {
            presenter?.presentAlertError(errorDescription: "Não foi possível favoritar \(heroData.name)")
            return false
        }
    }
    
    func deleteHeroData(heroId: Int) -> Bool {
        if DatabaseHelper.shareInstance.deleteHeroData(heroId: heroId) {
            return false
        } else {
            presenter?.presentAlertError(errorDescription: "Não foi possível desfavoritar")
            return true
        }
    }
}
