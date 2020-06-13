//
//  HeroesPresenter.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol HeroesPresentationLogic {
    func presentHeroes(response: Heroes.List.Response)
    func presentError(errorDescription: String)
    func toggleLoading(_ bool: Bool)
}

class HeroesPresenter: HeroesPresentationLogic {
    
    weak var viewController: HeroesDisplayLogic?
    
    // MARK: - Present Heroes
    
    func presentHeroes(response: Heroes.List.Response) {
        let viewModel = Heroes.List.ViewModel()
        viewController?.displayHeroes(viewModel: viewModel)
    }
    
    // MARK: - Present Error
    
    func presentError(errorDescription: String) {
        viewController?.displayError(errorDescription: errorDescription)
    }
    
    // MARK: - Toggle Loading
    
    func toggleLoading(_ bool: Bool) {
        viewController?.toggleLoading(bool)
    }
}
