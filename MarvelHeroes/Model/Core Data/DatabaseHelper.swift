//
//  DatabaseHelper.swift
//  MarvelHeroes
//
//  Created by Israel on 15/06/20.
//  Copyright © 2020 israel3D. All rights reserved.
//

import UIKit
import CoreData

final class DatabaseHelper {
    
    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveHeroData(data: HeroData) -> Bool {
        guard let imageData = data.image.jpegData(compressionQuality: 1.0) else { return false }
        let instance = HeroDataModel(context: context)
        instance.name = data.name
        instance.id = Int64(data.id)
        instance.image = imageData
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func fetchHeroData() -> [HeroData]? {
        var fetchingHeroData = [HeroData]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HeroDataModel")
        do {
            let heroesDataModel = try context.fetch(fetchRequest) as [AnyObject]
            for item in heroesDataModel {
                guard let id = item.value(forKey:"id") as? Int,
                let name = item.value(forKey:"name") as? String,
                let imageData = item.value(forKey:"image") as? Data,
                let image = UIImage(data: imageData) else {
                    return nil
                }
                let heroData = HeroData(id: id, name: name, image: image)
                fetchingHeroData.append(heroData)
            }
        } catch {
            return nil
        }
        return fetchingHeroData
    }
}
