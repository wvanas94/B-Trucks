//
//  MenuViewController.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    
    
    var menus = TIBMenus.getAllMenus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 376
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension MenuViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableViewCell
        let menu = menus[indexPath.row]
        
        cell.menu = menu
        
        return cell
    }
}
