//
//  Protocols.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Mesquita on 16/03/21.
//  Copyright © 2021 israel3D. All rights reserved.
//

import Foundation

protocol ViewSetupLayoutProtocol {
    func setupHierarchy()
    func setupContraints()
    func setupAdditionalStuff()
}

extension ViewSetupLayoutProtocol {
    func setupLayout() {
        setupHierarchy()
        setupContraints()
        setupAdditionalStuff()
    }
}
