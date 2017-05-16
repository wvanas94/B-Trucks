//
//  MenuTableViewCell.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class EditMenuTableViewCell: UITableViewCell {
    
    @IBOutlet var menuTitleLabel: UILabel!
    @IBOutlet var menuDescriptionLabel: UILabel!
    @IBOutlet var menuPrice: UILabel!
    
    
    var menuToEdit: MenuItems! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        menuTitleLabel.text = menuToEdit.title
        menuDescriptionLabel.text = menuToEdit.subtitle
        menuPrice.text = menuToEdit.price
    }
}
