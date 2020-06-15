//
//  MarvelInfo.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import Foundation

struct MarvelInfo: Decodable {
    let code: Int
    let status: String
    let data: MarvelData
}

struct MarvelData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results:  [Hero]
}

struct Hero: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail:Thumbnail
}

struct Thumbnail: Codable {
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
