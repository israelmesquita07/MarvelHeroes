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
    
    let presenter: HeroDetailsPresentationLogic
    let worker: FetchHeroImageServicing
    var hero: Hero?
    
    init(presenter: HeroDetailsPresentationLogic, worker: FetchHeroImageServicing) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Load Hero Image
    
    func loadHeroImage(request: HeroDetails.Details.Request) {
        guard let url = hero?.thumbnail.url, let hero = hero else {
            self.presenter.presentError(errorDescription: NSLocalizedString("error_generic", comment: String()))
            return
        }
        worker.fetchHeroImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                let response = HeroDetails.Details.Response(imageHero: image, hero: hero)
                self.presenter.presentHeroImage(response: response)
            case .failure(let error):
                self.presenter.presentError(errorDescription: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Core Data
    
    func markAsFavorite(heroData: HeroData) -> Bool {
        if DatabaseHelper.shareInstance.saveHeroData(data: heroData) {
            return true
        } else {
            presenter.presentAlertError(errorDescription: "\(NSLocalizedString("error_impossible_favorite", comment: String())) \(heroData.name)")
            return false
        }
    }
    
    func deleteHeroData(heroId: Int) -> Bool {
        if DatabaseHelper.shareInstance.deleteHeroData(heroId: heroId) {
            return false
        } else {
            presenter.presentAlertError(errorDescription: NSLocalizedString("error_impossible_unfavorite", comment: String()))
            return true
        }
    }
}
