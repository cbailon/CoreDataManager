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
    
    private var people: [Person] {
        return CoreDataManager.getInfo()
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
        let person: Person = CoreDataManager.createObject()
        person.name = name
        CoreDataManager.save()
        
        self.presenter.addPerson(person)
    }
    
    func editName (index: Int, newName: String?) {
        
        guard let name = newName else {
            self.delateName(index: index)
            return
        }
        
        if index >= people.count {
            print("index error")
            return
        }
        
        let person = people[index]
        person.name = name
        CoreDataManager.save()
        
        self.getNames()
    }
    
    func delateName (index: Int) {
        
        if index >= people.count {
            print("index error")
            return
        }
        
        let list: [Person] = CoreDataManager.getInfo()
        CoreDataManager.deleteObject(list[index])
        CoreDataManager.save ()
        
        self.presenter.removePerson(index: index)
    }
}
