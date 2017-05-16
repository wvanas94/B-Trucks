//
//  MenuViewController.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class EditMenuViewController: UIViewController {
    
    @IBAction func unwindToViewMenus(segue: UIStoryboardSegue) { }
    
    @IBOutlet var tableView: UITableView!
    
    var menusToView = TIBMenuItems.getAllMenuItems()
    
    let preferences = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menu_button_ = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(btnAddItem_Click(sender:)))
        
        self.navigationItem.rightBarButtonItem = menu_button_
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 376
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    func btnAddItem_Click(sender: UIButton) {
        preferences.removeObject(forKey: "passedID")
        preferences.set(sender.tag, forKey: "passedID")
        performSegue(withIdentifier: "addMenuItem", sender: self)
    }
}

extension EditMenuViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menusToView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editMenuCell") as! EditMenuTableViewCell
        let menu = menusToView[indexPath.row]
        
        cell.menuToEdit = menu
        
        return cell
    }
}
