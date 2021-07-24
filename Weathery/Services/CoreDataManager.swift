//
//  DataStoreManager.swift
//  Weathery
//
//  Created by Anon Account on 13.07.2021.
//

import Foundation
import CoreData

// Core Data stack
class CoreDataManager {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WeatherCD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }

        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func deleteManagedObject(_ managedObject: NSManagedObject) {
        managedContext.delete(managedObject)
        do {
            try managedContext.save()
        } catch {
            fatalError("Failed to delete object")
        }
    }
}

