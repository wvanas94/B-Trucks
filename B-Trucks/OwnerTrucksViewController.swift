//
//  TrucksViewController.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/5/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//
//
import UIKit

class TrucksViewController: UIViewController {
    
    @IBAction func unwindToTruckView(segue: UIStoryboardSegue) { }
    
    @IBOutlet var tableView: UITableView!
    
    let preferences = UserDefaults.standard
    
    var trucks = TrucksOwned.getAllTrucks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(trucks)
        print("Step 6")
        
        //        print(trucks)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 376
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    

}

extension TrucksViewController :
    UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return trucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerTrucksCell")! as! OwnerTrucksTableViewCell
        let truck = trucks[indexPath.row]
        
        
        cell.truck = truck
        
        print("truckId = \(cell.truckID)")
        
        cell.editTruckButton.tag = Int(cell.truckID)!
        cell.editTruckButton.addTarget(self, action: #selector(btnEdit_Click(sender:)), for: .touchUpInside)
        
        cell.truckSuggestionsButton.tag = Int(cell.truckID)!
        cell.truckSuggestionsButton.addTarget(self, action: #selector(btnSuggestion_Click(sender:)), for: .touchUpInside)

        return cell
    }
    
    func btnEdit_Click(sender: UIButton) {
        preferences.removeObject(forKey: "passedID")
        preferences.set(sender.tag, forKey: "passedID")
        performSegue(withIdentifier: "editTruckInfo", sender: self)
    }
    
    func btnSuggestion_Click(sender: UIButton) {
        preferences.removeObject(forKey: "passedID")
        preferences.set(sender.tag, forKey: "passedID")
        performSegue(withIdentifier: "suggestedItems", sender: self)
    }
    
}
