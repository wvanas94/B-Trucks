//
//  RecTableViewCell.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class RecTableViewCell: UITableViewCell {
    
    @IBOutlet var recTitleLabel: UILabel!
    @IBOutlet var recDescriptionLabel: UILabel!
    
    var rec: Rec! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        recTitleLabel.text = rec.title
        recDescriptionLabel.text = rec.description
        
        
        
    }
}
