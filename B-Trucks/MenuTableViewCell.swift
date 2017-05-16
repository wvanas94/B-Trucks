//
//  MenuTableViewCell.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet var menuTitleLabel: UILabel!
    @IBOutlet var menuDescriptionLabel: UILabel!
    
    @IBOutlet var menuPrice: UILabel!
    
    
    
    var menu: Menu! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        menuTitleLabel.text = menu.title
        menuDescriptionLabel.text = menu.subtitle
        
        
        
        
        
    }
}
