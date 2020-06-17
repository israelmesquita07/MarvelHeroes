//
//  HeroDetailsModels.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

enum HeroDetails {
    // MARK: Use cases
    
    enum Details {
        
        struct Request {
            
        }
        
        struct Response {
            let imageHero: UIImage
            let hero: Hero
        }
        
        struct ViewModel {
            let imageHero: UIImage
            let hero: Hero
        }
    }
}
