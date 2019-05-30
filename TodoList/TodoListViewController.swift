//
//  ViewController.swift
//  TodoList
//
//  Created by ChengChen on 10/25/18.
//  Copyright © 2018 ChengChen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["To find a job", "To make an app", "To fix the stock"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

//MARK - Tableview Datasource Methods
// these two functions are a must to use any tableview!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(itemArray[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: true) or change the option in the mainstoryoard
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New", message: "hello", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button
            
            //self.itemArray.append(textField.text!)
            self.itemArray.append(textField.text ?? "New Item")//if nil then set default to "New Item"
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type here"
            //print(alertTextField.text)
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated:  true, completion:  nil)
    }
}

