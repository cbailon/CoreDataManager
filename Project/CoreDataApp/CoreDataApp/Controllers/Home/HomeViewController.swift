//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Carlos Bailón Pérez on 09/06/2018.
//  Copyright © 2018 Carlos Bailon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var interactor: HomeInteractor!
    var model: HomeViewModel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup () {
        interactor = HomeInteractor()
        interactor.presenter = HomePresenter()
        interactor.presenter.viewController = self
        model = HomeViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "La lista"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.interactor.getNames()
    }

    @IBAction func addName(_ sender: UIBarButtonItem) {
        self.presentAddAlert()
    }
 
    //    MARK: Presentation logic
    
    
    //    MARK: Private methods
    
    private func presentAddAlert() {
        
        let alert = UIAlertController(title: "Nuevo nombre", message: "Añade un nuevo nombre", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Guardar", style: .default) { (action) in
            self.interactor.addName(name: alert.textFields?.first?.text)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    private func presentEditAlert(index: Int) {
        
        let alert = UIAlertController(title: "Editar nombre", message: "Edita el nombre", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Editar", style: .default) { (action) in
            self.interactor.editName(index: index, newName: alert.textFields?.first?.text)
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alert.addTextField()
        alert.textFields?.first?.text = self.model.names[index]
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.model.names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            self.interactor.delateName(index: indexPath.row)
            break
        default:
            break
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.presentEditAlert(index: indexPath.row)
    }
}

