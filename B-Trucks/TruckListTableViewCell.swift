//
//  TruckTableViewCell.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/5/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class TruckTableViewCell: UITableViewCell
{
    
    @IBOutlet var truckImageView: UIImageView!
    @IBOutlet var truckNameLabel: UILabel!
    @IBOutlet var truckNameInfo: UILabel!
    
    var truckID: String = ""
    
    @IBOutlet var suggestionButton: UIButton!
    @IBOutlet var menuButton: UIButton!
    
    var truck: Trucks! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        truckNameLabel.text = truck.name
        truckNameInfo.text = truck.info
        truckID = truck.id
    }
}
