//
//  HomeInteractor.swift
//  CoreDataApp
//
//  Created by Carlos Bailón Pérez on 09/06/2018.
//  Copyright © 2018 Carlos Bailon. All rights reserved.
//

import UIKit
import CoreDataManager

class HomeInteractor {

    var presenter: HomePresenter!
    
    private var people: [Person]? {
        return try? CoreDataManager.shared.getAllEntitys() ?? []
    }
    
    
    //    MARK: Bussines logic
    
    func getNames () {
        presenter.presentPersons(persons: people)
    }
    
    func addName (name: String?) {
        guard let name = name else {
            print("El nombre es nil")
            return
        }
        do {
            let person: Person = try CoreDataManager.shared.createObject()
            person.name = name
            try CoreDataManager.shared.save()
            self.presenter.addPerson(person)
        } catch {}
    }
    
    func editName (index: Int, newName: String?) {
        
        guard let people = self.people else { return }
        
        guard let name = newName else {
            self.deleteName(index: index)
            return
        }
        
        if index >= people.count {
            print("index error")
            return
        }
        
        let person = people[index]
        person.name = name
        do {
            try CoreDataManager.shared.save()
        } catch {}
        
        
        self.getNames()
    }
    
    func deleteName (index: Int) {
        
        guard let people = self.people else { return }
        
        if index >= people.count {
            print("index error")
            return
        }
        
        do {
            guard let list: [Person] = try CoreDataManager.shared.getAllEntitys() else { return }
            try CoreDataManager.shared.deleteObject(list[index])
            try CoreDataManager.shared.save ()
            
            self.presenter.removePerson(index: index)
        } catch { }
        
    }
}
