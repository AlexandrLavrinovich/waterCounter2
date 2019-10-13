//
//  TableViewController.swift
//  WaterCounter
//
//  Created by MacBook Pro on 13.10.2019.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var waterList: [Int] {
        set {
            UserDefaults.standard.set(newValue, forKey: "ToDoDrinkings")
            UserDefaults.standard.synchronize()
            
            let result: Int = sumOfDrink()
            labelText.text = "\(result)" + " мл"
            //tableView.reloadData()
        }
        
        get {
            if let array = UserDefaults.standard.array(forKey: "ToDoDrinkings") as? [Int] {
                return array
            } else {
                return []
            }
        }
    }


    func addDrinking(drinkInMililiters: Int) {
        waterList.append(drinkInMililiters)

        
    }

    func removeDrinking(at index: Int) {
        waterList.remove(at: index)
        
    }

    func sumOfDrink() -> Int {
        var s = 0
        for i in waterList {
            s = s + i
        }
        return s
    }

    @IBOutlet weak var labelText: UILabel!
    
    @IBAction func pushRefresh(_ sender: Any) {
        let result: Int = sumOfDrink()
        labelText.text = "\(result)" + " мл"
        
    }
    @IBAction func pushAddWater(_ sender: Any) {
        let alertController = UIAlertController(title: "Добавить количество выпитой воды", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Количество выпитой воды в мл"
        }
        
        let alertActioin1 = UIAlertAction(title: "Отменить", style: .default) {
            (alert) in
        }
        
        let alertActioin2 = UIAlertAction(title: "Добавить", style: .cancel) {
            (alert) in
            let newField: Int? = Int (alertController.textFields![0].text!)
            self.addDrinking(drinkInMililiters: newField ?? 0)
            self.tableView.reloadData()
        }
        
        alertController.addAction(alertActioin1)
        alertController.addAction(alertActioin2)
        present(alertController, animated: true, completion: nil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return waterList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewBox", for: indexPath)
        
        let currentDrinking = String (waterList[indexPath.row])
        
        cell.textLabel?.text = currentDrinking + " мл"
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeDrinking(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


}
