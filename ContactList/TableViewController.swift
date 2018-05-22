//
//  ViewController.swift
//  ContactList
//
//  Created by Alan Chen on 5/22/18.
//  Copyright © 2018 Alphie. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, AddViewControllerDelegate {
    
    var items = [List]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 85
        fetchAllItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = items[indexPath.row].firstName! + " " + items[indexPath.row].lastName!
        cell.numberLabel.text = items[indexPath.row].number!
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addViewController = navigationController.topViewController as! AddViewController
            addViewController.delegate = self
            
            if let indexPath = sender as? IndexPath {
                let navigationController = segue.destination as! UINavigationController
                let addViewController = navigationController.topViewController as! AddViewController
                let note = items[indexPath.row]
                addViewController.note = note
                addViewController.indexPath = indexPath
            }
            
        }
        else if segue.identifier == "ItemInfoSegue" {
            let navigationController = segue.destination as! UINavigationController
            let addTableViewController = navigationController.topViewController as! ViewViewController
            let indexPath = sender as! IndexPath
            addTableViewController.item = items[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in print("Button Pressed")
        }
        let view = UIAlertAction(title: "View", style: .default) { (action) in
            self.performSegue(withIdentifier: "ItemInfoSegue", sender: indexPath)
        }
        let edit = UIAlertAction(title: "Edit", style: .default) { (action) in
            self.performSegue(withIdentifier: "addItemSegue", sender: indexPath)
        }
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            let item = self.items[indexPath.row]
            self.managedObjectContext.delete(item)
            do{
                try self.managedObjectContext.save()
            }
            catch {
                print("\(error)")
            }
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
        }

        actionSheet.addAction(view)
        actionSheet.addAction(edit)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [List]
        } catch {
            print("\(error)")
        }
    }
    
    func addItem(by controller: AddViewController, with firstName: String, with lastName: String, with number: String, at indexPath: IndexPath?) {
        
        if let ip = indexPath {
            let item = items[ip.row]
            item.firstName = firstName
            item.lastName = lastName
            item.number = number
        }
        else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "List", into: managedObjectContext) as! List
            item.firstName = firstName
            item.lastName = lastName
            item.number = number
            items.append(item)
        }
        print("Received text from top view: \(firstName)")
        
        do {
            try managedObjectContext.save()
        }
        catch {
            print("\(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

}

