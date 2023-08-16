//
//  ViewController.swift
//  Todoey
//
//  Created by Akbarjon Juramirzaev on 10/08/23.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray: [Item] = []
    
    // Data file path for stored items
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appending(component: "Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create Add (+) Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        // Method to load the items from the itemArray
        loadItems()
    }
    
    //MARK: - TableView Datasource Controller
    // Function to find out the number of cell to populate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // Function to find the location of the cell to populate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        // Populate cell with item
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        cell.contentConfiguration = content
        
        // Check whether item is done
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done.toggle()
        // Method to store change in "done" property of "Item" class into "Items.plist"
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @objc func addButtonPressed() {
        
        var textField = UITextField()
        
        // Create Alert pop-up
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        // Create action
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            // Append new Item into itemArray
            let newItem = Item()
            newItem.title = textField.text! // -> take care of blank TextField!!!
            self.itemArray.append(newItem)
            
            // Method to store change in "item" property of "Item" class into "Items.plist"
            self.saveItems()
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
    
    //MARK: - Model Manipulation Methods
    // Method to encode the items from "itemArray" and save into "Items.plist"
    func saveItems() {
        let encoder = PropertyListEncoder()
        do  {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error in encoding item array, \(error)")
        }
        tableView.reloadData() // -> reloadData() because of new item added
    }
    
    // Method to decode the items from "Items.plist" and save into "itemArray"
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error in decoding item array, \(error)")
            }
        }
    }
    
}

