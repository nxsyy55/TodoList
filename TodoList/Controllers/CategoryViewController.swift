//
//  CategoryViewController.swift
//  TodoList
//
//  Created by ChengChen on 2019/6/2.
//  Copyright © 2019 ChengChen. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var cateArray = [Cate]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCates()
    }

    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let cate = cateArray[indexPath.row]
        
        cell.textLabel?.text = cate.name
        
        return cell
        
    }
    
    //Mark: - TableView Manipulation Methods
    func saveCates() {
        
        do {
            try context.save()
        } catch {
            print("error")
        }
        self.tableView.reloadData()
        
    }
    
    func loadCates(with request:NSFetchRequest<Cate> = Cate.fetchRequest()) {
 
        do {
            cateArray = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add new Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            var textField = UITextField()
    
            let alert = UIAlertController(title: "Add New Cate", message: "Go!", preferredStyle: .alert)
    
            let action = UIAlertAction(title: "Add Cate", style: .default) { (action) in
                let newCate = Cate(context: self.context)
                
                if textField.text!.count == 0 {
                    
                } else {
                    newCate.name = textField.text!
                    self.cateArray.append(newCate)
                    self.saveCates()
                    
                }
            }
    
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Type here"
                textField = alertTextField
            }
    
            alert.addAction(action)
            present(alert, animated:  true, completion:  nil)
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        saveCates()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
