//
//  ViewController.swift
//  realmImplementation
//
//  Created by mandip on 27/07/2024.
//

import UIKit
import RealmSwift

class toDoEyViewController: UITableViewController {
    var itemArray:Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
            loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell",for: indexPath)
        if let item = itemArray?[indexPath.row]{
            cell.textLabel?.text=item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item=itemArray?[indexPath.row]{
            do{
                try! realm.write{
                    item.done = !item.done
                }
            }catch{
                print(error)
            }
                    }
      
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField=UITextField()
        let alert=UIAlertController(title: "add item", message: "", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        let action = UIAlertAction(title: "done", style: .default) { action in
            if let currentCategory=self.selectedCategory{
                do{
                    try! self.realm.write{
                        let newItem=Item()
                        newItem.title=textField.text!
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print(error)
                }
            }
            
            self.tableView.reloadData()
            
            
        }
        alert.addTextField { field in
            textField=field
        }
        alert.addAction(action)
    }
    
    func loadData(){
        itemArray=selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
}

