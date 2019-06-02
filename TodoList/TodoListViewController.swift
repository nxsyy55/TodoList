//
//  ViewController.swift
//  TodoList
//
//  Created by ChengChen on 10/25/18.
//  Copyright © 2018 ChengChen. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    // MARK: - Remember you can use MARKS!
    var itemArray = [Item]()
    
    //!!!!! the key line !!!!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }

    //MARK: - Tableview Datasource Methods
// these two functions are a must to use any tableview!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        // above line reads like ifelse
        
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // or one can do, so many method to achieve one same goal!
        // itemArrat[indexPath.row].setValue("False", forKey: "done")
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New", message: "hello", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            
            //what will happen once the user clicks the Add Item button
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            self.itemArray.append(newItem)
           
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type here"
            //print(alertTextField.text)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated:  true, completion:  nil)
    }


    func saveItems() {
    
        do {
            try context.save()
        } catch {
            print("error")
        }
        self.tableView.reloadData()
}

    func loadItems() {

        // it's like a common couple of lines, just remember
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
    }
    
}


// always keep the codes in chopps
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        print(searchBar.text!)
    }
}
