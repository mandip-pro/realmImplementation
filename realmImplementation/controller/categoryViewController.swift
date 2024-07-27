//
//  categoryViewController.swift
//  realmImplementation
//
//  Created by mandip on 27/07/2024.
//

import UIKit
import RealmSwift

class categoryViewController: UITableViewController {
    var categoryArray:Results<Category>?
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadData()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text=categoryArray?[indexPath.row].name ?? "no categories"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc=segue.destination as? toDoEyViewController
        if let indexPath=tableView.indexPathForSelectedRow{
            destinationVc!.selectedCategory=categoryArray?[indexPath.row]
        }
    }

   

   
   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Category", message: "", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        let action = UIAlertAction(title: "done", style: .default) { action in
            let newCategory=Category()
            newCategory.name=textField.text!
            self.save(category: newCategory)
            
        }
        alert.addTextField { field in
            textField=field
        }
        alert.addAction(action)
    }
    
    func save(category:Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    func loadData(){
        categoryArray=realm.objects(Category.self)
        tableView.reloadData()
    }
    
}
