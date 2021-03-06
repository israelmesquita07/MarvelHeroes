//
//  HeroesModels.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

enum Heroes {
    // MARK: Use cases
    
    enum List {
        
        struct Request {
            let heroName: String
        }
        
        struct Response {
            let heroes: [Hero]
        }
        
        struct ViewModel {
            let heroes: [Hero]
        }
    }
}
