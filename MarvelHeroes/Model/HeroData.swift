//
//  HeroData.swift
//  MarvelHeroes
//
//  Created by Israel on 15/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit

final class HeroData: NSObject {
    let id: Int
    let name: String
    let image: UIImage
    
    init(id: Int, name: String, image: UIImage) {
        self.id = id
        self.name = name
        self.image = image
    }
}
