//
//  MarvelInfo.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation

final class MarvelInfo: Decodable {
    let code: Int
    let status: String
    let data: MarvelData
}

final class MarvelData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Hero]
}

final class Hero: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
    private var _isFavorite: Bool?
    var isFavorite: Bool? {
        get {
            return self._isFavorite
        } set (newValue) {
            self._isFavorite = newValue
        }
    }
}

final class Thumbnail: Codable {
    let path: String
    let ext: String
    var url: String {
        return path + "." + ext
    }
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
