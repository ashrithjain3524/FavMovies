//
//  PersistanceService.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 10/07/22.
//

import Foundation
import CoreData

class PersistanceService {
    
    public init() {}
    static let shared = PersistanceService()
    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Favourite_Movies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                let nserror = error as NSError
                print("Unresolved error\(nserror.localizedDescription)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                print("****Saved****")
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error\(nserror.localizedDescription)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? []
        }
        catch {
            print(error)
            return [T]()
        }
    }
    
    func fetchDataBasedonId<T: NSManagedObject>(_ objectType: T.Type, _ pred: NSPredicate?) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = pred
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? []
        }
        catch {
            print(error)
            return [T]()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        self.saveContext()
    }
}


