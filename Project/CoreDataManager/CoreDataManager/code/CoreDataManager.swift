//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Carlos Bailón Pérez on 09/06/2018.
//  Copyright © 2018 Carlos Bailon. All rights reserved.
//

import CoreData

public class CoreDataManager {
    
    private static var managedContext: NSManagedObjectContext?
    
    public static func configure (withContext context: NSManagedObjectContext) {
        self.managedContext = context
    }
    
    public static func  getInfo <T: NSManagedObject> (withPredicate predicate: NSPredicate? = nil) -> [T] {
        
        let managedContext = self.getManagedContext()
        
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self));
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    public static func createObject <T: NSManagedObject> () -> T {
        
        let managedContext = self.getManagedContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: managedContext), let obj = NSManagedObject(entity: entity, insertInto: managedContext) as? T else {
            fatalError("entity dosen´t exist")
        }
        return obj
    }
    
    public static func deleteObject (_ object: NSManagedObject) {
        let managedContext = self.getManagedContext()
        managedContext.delete(object)
    }
    
    public static func save () {
        let managedContext = self.getManagedContext()
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    //    MARK: Private methods
    
    static func getManagedContext () -> NSManagedObjectContext {
        guard let managedContext = self.managedContext else {
            fatalError("managedContext is not set")
        }
        return managedContext
    }
}
