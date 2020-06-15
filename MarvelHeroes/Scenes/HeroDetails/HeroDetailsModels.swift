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
    
    enum Hero {
        
        struct Request {
            
        }
        
        struct Response {
            let imageHero: UIImage
            let heroDescription: String
        }
        
        struct ViewModel {
            let imageHero: UIImage
            let heroDescription: String
        }
    }
}
