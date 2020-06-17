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
    var _isFavorite: Bool?
    var isFavorite: Bool? {
        get {
            return self._isFavorite
        } set (newValue) {
            self._isFavorite = newValue
        }
    }
    
    init(id: Int, name: String, description: String, thumbnail: Thumbnail) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
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
    
    init(path: String, ext: String) {
        self.path = path
        self.ext = ext
    }
}
