//
//  HomeTableViewController.swift
//  MortgageCalculator
//
//  Created by Joe on 8/25/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var mortgageController: MortgageController?
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mortgageController?.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mortgageController?.loadFromPersistentStore()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mortgageController?.houseArray.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath)
        
        let info = mortgageController?.houseArray[indexPath.row]
        cell.textLabel?.text = info?.address
        cell.detailTextLabel?.text = formatter.string(from: info?.calculatedMortgage ?? 0)
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            mortgageController?.houseArray.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            mortgageController?.saveToPersistentStore()
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            if let indexPath = tableView.indexPathForSelectedRow, let vc = segue.destination as? HomeDetailViewController {
                vc.houseDelegate = mortgageController?.houseArray[indexPath.row]
            }
        }
    }
}

