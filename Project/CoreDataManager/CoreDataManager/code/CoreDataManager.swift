//
//  CoreDataManager.swift
//  CoreDataManager
//
//  Created by Carlos Bailón Pérez on 09/06/2018.
//  Copyright © 2018 Carlos Bailon. All rights reserved.
//

import CoreData

public class CoreDataManager {
    
    enum CoreDataManagerError: Error {
        case managedContextNotSet
        case cantGetEntity
        case cantSaveContext
    }
    
    public static let shared = CoreDataManager()
    
    private var managedContext: NSManagedObjectContext?
    
    public func configure (withContext context: NSManagedObjectContext) {
        self.managedContext = context
    }
    
    public func getAllEntitys <T: NSManagedObject> (withPredicate predicate: NSPredicate? = nil) throws -> [T]? {
        do {
            let managedContext = try self.getManagedContext()
            let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self));
            
            if let predicate = predicate {
                fetchRequest.predicate = predicate
            }
            
            do {
                return try managedContext.fetch(fetchRequest)
            } catch {
                throw CoreDataManagerError.cantGetEntity
            }
        }
    }
    
    public func getFirstEntity <T: NSManagedObject> (withPredicate predicate: NSPredicate? = nil) throws -> T? {
        do {
            return try self.getAllEntitys(withPredicate: predicate)?.first
        } catch {
            throw CoreDataManagerError.cantGetEntity
        }
    }
    
    public func createObject <T: NSManagedObject> () throws -> T {
        do {
            let managedContext = try self.getManagedContext()
            guard let entity = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: managedContext), let obj = NSManagedObject(entity: entity, insertInto: managedContext) as? T else {
                fatalError("entity dosen´t exist")
            }
            return obj
        }
    }
    
    public func deleteObject (_ object: NSManagedObject) throws {
        do {
            let managedContext = try self.getManagedContext()
            managedContext.delete(object)
        }
    }
    
    public func save () throws {
        do {
            let managedContext = try self.getManagedContext()
            do {
                try managedContext.save()
            } catch {
                throw CoreDataManagerError.cantSaveContext
            }
        }
    }
    
    
    
    //    MARK: Private methods
    
    private func getManagedContext () throws -> NSManagedObjectContext {
        guard let managedContext = self.managedContext else {
            throw CoreDataManagerError.managedContextNotSet
        }
        return managedContext
    }
}
