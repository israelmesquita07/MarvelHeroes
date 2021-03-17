//
//  HeroesError.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation

enum HeroesError: Error {
    case invalidUrl
    case internetFailure
    case decodeError(Error)
    
    var localizedDescription: String {
        switch self {
        case .internetFailure:
            return NSLocalizedString("error_internet_failure", comment: String())
        default:
            return "\(NSLocalizedString("error_generic", comment: String()))!"
        }
    }
}
