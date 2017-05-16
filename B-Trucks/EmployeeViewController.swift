//
//  EmployeeViewController.swift
//  B-Trucks
//
//  Created by Wesley Van As on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOut(_ sender: Any) {
        let preferences = UserDefaults.standard
        var login_session:String = ""
        
        preferences.removeObject(forKey: "session")
        
        login_session = preferences.string(forKey: "session")!
        
        let myUrl = URL(string: "https://cgi.soic.indiana.edu/~team18/truckSwitch.php")
        
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        let postString = "session=\(login_session)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            do {
            }
        }
        task.resume()
        
        OperationQueue.main.addOperation {
            self.performSegue(withIdentifier: "employeeToLogin", sender: self)
        }
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
