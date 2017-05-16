//
//  TruckInfoViewController.swift
//  B-Trucks
//
//  Created by Wesley Van As on 3/30/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class TruckInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func suggestItem(_ sender: Any) {
        performSegue(withIdentifier: "suggestItem", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
