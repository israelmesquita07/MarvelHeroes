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
    func fillDataToDetails(hero: Hero)
}

protocol HeroesDataStore {
    var hero: Hero? { get set }
}

final class HeroesInteractor: HeroesBusinessLogic, HeroesDataStore {
    
    var presenter: HeroesPresentationLogic?
    var worker: ListHeroesServicing?
    var hero: Hero?
    
    // MARK: - Load Heroes
    
    func loadHeroes(request: Heroes.List.Request) {
        presenter?.toggleLoading(true)
        worker = worker ?? HeroesWorker()
        worker?.fetchHeroes(name: request.heroName, page: 1, completion: { result in
//            guard let self = self else {
//                print("weak self")
//                return }
            switch result {
            case .success(let heroes):
                let response = Heroes.List.Response(heroes: heroes.data.results)
                self.presenter?.presentHeroes(response: response)
                self.presenter?.toggleLoading(false)
            case .failure(let error):
                self.presenter?.presentError(errorDescription: error.localizedDescription)
                self.presenter?.toggleLoading(false)
            }
        })
    }
    
    func fillDataToDetails(hero: Hero) {
        self.hero = hero
    }
}
