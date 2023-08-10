//
//  ViewController.swift
//  Todoey
//
//  Created by Akbarjon Juramirzaev on 10/08/23.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Learn iOS", "Do Work out", "Do research on news in iOS"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

}

