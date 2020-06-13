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
}

protocol HeroesDataStore {
    
}

class HeroesInteractor: HeroesBusinessLogic, HeroesDataStore {
    
    var presenter: HeroesPresentationLogic?
    var worker: ListHeroesServicing?
    
    // MARK: Load Heroes
    
    func loadHeroes(request: Heroes.List.Request) {
        worker = worker ?? HeroesWorker()
        worker?.fetchHeroes()
        
        let response = Heroes.List.Response()
        presenter?.presentHeroes(response: response)
    }
}
