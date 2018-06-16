//
//  HomePresenter.swift
//  CoreDataApp
//
//  Created by Carlos Bailón Pérez on 09/06/2018.
//  Copyright © 2018 Carlos Bailon. All rights reserved.
//

import Foundation

class HomePresenter {
    
    weak var viewController: HomeViewController?
    
    func presentPersons (persons: [Person]?) {
        
        var names = [String]()
        
        for person in persons ?? [] {
            if let name = person.name {
                names.append(name)
            }
        }
        
        self.viewController?.model.names = names
        self.viewController?.tableView.reloadData()
    }
    
    func addPerson (_ person: Person) {
        guard let name = person.name else {
            return
        }
        self.viewController?.model.names.append(name)
        self.viewController?.tableView.insertRows(at: [IndexPath(row: self.viewController!.model.names.count - 1, section: 0)], with: .right)
    }
    
    func removePerson (index: Int) {
        self.viewController?.model.names.remove(at: index)
        self.viewController?.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .top)
    }
}
