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
    
    func presentNames (persons: [Person]?) {
        
        var names = [String]()
        
        for person in persons ?? [] {
            if let name = person.name {
                names.append(name)
            }
        }
        
        self.viewController?.model.names = names
        self.viewController?.tableView.reloadData()
    }
}
