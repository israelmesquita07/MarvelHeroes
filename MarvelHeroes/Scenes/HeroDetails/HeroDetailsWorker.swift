//
//  HeroDetailsWorker.swift
//  MarvelHeroes
//
//  Created by Israel on 14/06/20.
//  Copyright (c) 2020 israel3D. All rights reserved.
//

import UIKit

protocol FetchHeroImageServicing {
    func fetchHeroImage(url: String, completion: @escaping(Result<UIImage,HeroesError>) -> Void)
}

final class HeroDetailsWorker: FetchHeroImageServicing {
    
    func fetchHeroImage(url: String, completion: @escaping(Result<UIImage,HeroesError>) -> Void) {
        guard let urlImage = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: urlImage, completionHandler: { (data, _, error) in
            if error == nil, let data = data {
                guard let image = UIImage(data: data) else {
                    completion(.failure(.internetFailure))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                completion(.failure(.internetFailure))
            }
        })
        dataTask.resume()
    }
}
