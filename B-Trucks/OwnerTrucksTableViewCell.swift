//
//  TruckTableViewCell.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/5/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class OwnerTrucksTableViewCell: UITableViewCell
{

    @IBOutlet var truckNameLabel: UILabel!
    var truckID: String = ""
    @IBOutlet var editTruckButton: UIButton!
    @IBOutlet var truckSuggestionsButton: UIButton!
    
    var truck: ownerTrucks! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        truckNameLabel.text = truck.name
        truckID = truck.id
    }
}
