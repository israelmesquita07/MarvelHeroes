//
//  HeroesWorker.swift
//  MarvelHeroes
//
//  Created by Israel on 13/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol ListHeroesServicing {
    func fetchHeroes(name:String, page:Int, completion: @escaping(Result<MarvelInfo, HeroesError>) -> Void)
}

final class HeroesWorker: ListHeroesServicing {
    
    func fetchHeroes(name:String, page:Int, completion: @escaping(Result<MarvelInfo, HeroesError>) -> Void) {
        
        let urlString = getUrl(name: name, page: page)
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.internetFailure))
                }
                return
            }
            do {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.internetFailure))
                    }
                    return
                }
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(MarvelInfo.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError(error)))
                }
            }
        }
        dataTask.resume()
    }
    
    private func getUrl(name:String, page:Int) -> String {
        let basepath = "http://gateway.marvel.com/v1/public/characters?"
        let limit = 50
        let offset = page * limit
        var startsWith: String = ""
        if !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        }
        return basepath + "offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
    }
    
    private func getCredentials() -> String {
        let privateKey = "cd00c969a6285e3cc4992ff41ea4f4c8b3a42ddc"
        let publicKey = "2bb07766e1619e2a92851dab2427de2b"
        let ts = String(Date().timeIntervalSince1970)
        let hash = (ts+privateKey+publicKey).md5Value.lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
}
