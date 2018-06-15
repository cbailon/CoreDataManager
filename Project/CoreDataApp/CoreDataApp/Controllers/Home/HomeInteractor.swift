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
        presenter.presentNames(persons: people)
    }
    
    func addName (name: String?) {
        guard let name = name else {
            print("El nombre es nil")
            return
        }
        
        CoreDataManager.save {
            let person: Person = CoreDataManager.createObject()
            person.name = name
        }
        self.getNames()
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
        CoreDataManager.save {
            let person = people[index]
            person.name = name
        }
        
        self.getNames()
    }
    
    func delateName (index: Int) {
        
        if index >= people.count {
            print("index error")
            return
        }
        CoreDataManager.save {
            let list: [Person] = CoreDataManager.getInfo()
            CoreDataManager.deleteObject(list[index])
        }
        
        self.getNames()
    }
}
