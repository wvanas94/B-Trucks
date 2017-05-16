//
//  RecsViewController.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class RecsViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    
    
    var recs = TIBRecs.getAllRecs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 376
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension RecsViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return recs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecsCell") as! RecTableViewCell
        let rec = recs[indexPath.row]
        
        cell.rec = rec
        
        return cell
    }
}
