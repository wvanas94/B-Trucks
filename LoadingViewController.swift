//
//  LoadingViewController.swift
//  B-Trucks
//
//  Created by Wesley Van As on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class LoadingViewController: UIViewController {

    @IBAction func unwindToLoadscreen(segue: UIStoryboardSegue) { }
    
    let LocationMgr = CLLocationManager()
    
    var login_session:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        LocationMgr.requestAlwaysAuthorization()
        
        let preferences = UserDefaults.standard
        
//        --Uncomment to reset key for "session"
//        preferences.removeObject(forKey: "session")
//        preferences.removeObject(forKey: "firstName")
//        preferences.removeObject(forKey: "lastName")
//        preferences.removeObject(forKey: "password")
//        preferences.removeObject(forKey: "id")
//        preferences.removeObject(forKey: "type")

        if preferences.object(forKey: "session") != nil
        {
            login_session = preferences.object(forKey: "session") as! String
            
            let myUrl = URL(string: "https://cgi.soic.indiana.edu/~team18/checkSession.php")
            
            var request = URLRequest(url: myUrl!)
            request.httpMethod = "POST"
            let postString = "session=\(login_session)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                print("data = \(data!)")
                do {
                    print("Checkpoint")
                    //converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = myJSON {
                        
                        preferences.set(parseJSON["userID"], forKey: "userID")
                        let typeOfUser = parseJSON["userType"]
                        print("user type = \(typeOfUser)")
                        //                        print("Parsed JSON = \(parseJSON)")
                        OperationQueue.main.addOperation {
                            self.performSegue(withIdentifier: typeOfUser as! String, sender: self)
                        }
                        
                    }
                } catch {
                    print("Error is \(error)")
                }
            }
            task.resume()
        } else {
            OperationQueue.main.addOperation {
                self.performSegue(withIdentifier: "goToLogin", sender: self)
            }
        }

        // Do any additional setup after loading the view.
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
