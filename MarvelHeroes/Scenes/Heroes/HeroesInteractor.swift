//
//  HeroesInteractor.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroesBusinessLogic {
    func loadHeroes(request: Heroes.List.Request)
    func searchHeroes(request: Heroes.List.Request)
    func fillDataToDetails(hero: Hero)
    func markAsFavorite(heroData: HeroData) -> Bool
    func deleteHeroData(heroId: Int) -> Bool
}

protocol HeroesDataStore {
    var hero: Hero? { get set }
}

final class HeroesInteractor: HeroesBusinessLogic, HeroesDataStore {
    
    let presenter: HeroesPresentationLogic
    let worker: ListHeroesServicing
    var hero: Hero?
    var page = 0, totalHeros = 1
    var results: [Hero] = []
    
    init(presenter: HeroesPresentationLogic, worker: ListHeroesServicing) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Load Heroes
    
    func loadHeroes(request: Heroes.List.Request) {
        if results.count >= totalHeros {
            return
        }
        presenter.toggleLoading(true)
        worker.fetchHeroes(name: request.heroName, page: page, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let heroes):
                self.page += 1
                self.totalHeros = heroes.data.total
                self.results += heroes.data.results
                self.fetchFavorites()
                if self.results.count > 0 {
                    let response = Heroes.List.Response(heroes: self.results)
                    self.presenter.presentHeroes(response: response)
                    self.presenter.toggleLoading(false)
                    return
                }
                self.presenter.presentError(errorDescription: NSLocalizedString("error_empty_heroes", comment: String()))
                self.presenter.toggleLoading(false)
            case .failure(let error):
                self.presenter.presentError(errorDescription: error.localizedDescription)
                self.presenter.toggleLoading(false)
            }
        })
    }
    
    func searchHeroes(request: Heroes.List.Request) {
        resetVariables()
        loadHeroes(request: request)
    }
    
    func fillDataToDetails(hero: Hero) {
        self.hero = hero
    }
    
    private func resetVariables() {
        page = 0
        totalHeros = 1
        results = []
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
    
    private func fetchFavorites() {
        if let arrHeroes = DatabaseHelper.shareInstance.fetchHeroData() {
            for item in results {
                for itemData in arrHeroes {
                    item._isFavorite = itemData.id == item.id
                }
            }
        }
    }
}
