//
//  ViewController.swift
//  Todoey
//
//  Created by Akbarjon Juramirzaev on 10/08/23.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Learn iOS", "Do Work out", "Do research on news in iOS"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create Add (+) Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
    }
    
    //MARK: - TableView Datasource Controller
    // Function to find out the number of cell to populate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // Function to find the location of the cell to populate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = itemArray[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isRowSelected = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        tableView.cellForRow(at: indexPath)?.accessoryType = isRowSelected ? .none : .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @objc func addButtonPressed() {
        
        var textField = UITextField()
        
        // Create Alert pop-up
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Create action
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        }
        
        // Add TextField to Alert
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        // Add action to Alert
        alert.addAction(action)
        
        // Present Alert pop-up
        present(alert, animated: true, completion: nil)
    }
}

