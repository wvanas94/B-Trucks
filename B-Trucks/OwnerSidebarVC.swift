//
//  BackTableVC.swift
//  B-Trucks
//
//  Created by Mike Patton on 3/6/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import Foundation

class OwnerSidebarVC: UITableViewController {
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Edit Profile","View Trucks","Sign Out"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        if cell.textLabel?.text == "Edit Profile" as String {
            NSLog("You selected cell number: \(indexPath.row)!")
            self.performSegue(withIdentifier: "truckSettings", sender: self)
        }
        if cell.textLabel?.text == "View Trucks" as String {
            NSLog("You selected cell number: \(indexPath.row)!")
            print("Uh Oh")
            self.performSegue(withIdentifier: "viewTrucks", sender: self)
        }
        
        if cell.textLabel?.text == "Sign Out" as String {
            NSLog("You selected cell number: \(indexPath.row)!")
            let preferences = UserDefaults.standard
            var login_session:String = ""
            login_session = preferences.string(forKey: "session")!
            
            preferences.removeObject(forKey: "session")
            preferences.removeObject(forKey: "firstName")
            preferences.removeObject(forKey: "lastName")
            preferences.removeObject(forKey: "password")
            preferences.removeObject(forKey: "id")
            preferences.removeObject(forKey: "type")
            
            let myUrl = URL(string: "https://cgi.soic.indiana.edu/~team18/signOut.php")
            
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
                self.performSegue(withIdentifier: "userToLogin", sender: self)
            }
        }
    }
}




























