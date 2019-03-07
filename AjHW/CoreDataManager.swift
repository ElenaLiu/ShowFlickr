//
//  CoreDataManager.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/7.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    func createFavorite(_ urlString: String, _ title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let photo = FavoritePhoto(context: managedContext)
        photo.title = title
        photo.imageURLString = urlString
        photo.isFavorite = true
        
        appDelegate.saveContext()
    }
    
    func fetchFavorites() -> [FavoritePhoto]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        return try? managedContext.fetch(FavoritePhoto.fetchRequest())
        
    }
    
    func deleteFavorite(_ urlString: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePhoto")
        fetchRequest.predicate = NSPredicate(format: "imageURLString = %@", urlString)
        
        do {
            let photos = try managedContext.fetch(fetchRequest)
            let photoToDelete = photos.first as! NSManagedObject
            managedContext.delete(photoToDelete)
            
            appDelegate.saveContext()
            
        } catch (let error) {
            print("DeleteFavorite error ", error.localizedDescription)
        }
    }
}
