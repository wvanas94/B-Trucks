//
//  LogInScreen.swift
//  B-Trucks
//
//  Created by Wesley Van As on 1/17/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class LogIn: UIViewController, CLLocationManagerDelegate {
    
    let LocationMgr = CLLocationManager()
    
    @IBOutlet var _Email: UITextField!
    @IBOutlet var _Password: UITextField!
    
    var login_session:String = ""
    
    struct GlobalVariable {
        static var msg = String()
        static var existingEmail: Bool = false
        static var userType = String()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogIn.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    func validatePassword(candidate: String) -> Bool {
        let passwordRegex = "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{6,15}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: candidate)
    }
    
    
    @IBAction func LogInButton(_ sender: AnyObject) {
        //let username = _Email.text
        //let password = _Password.text
        let emailValidated = validateEmail(candidate: _Email.text!)
        let passwordValidated = validatePassword(candidate: _Password.text!)
        
        if (emailValidated == false || passwordValidated == false) {
            let alert = UIAlertController(title: "Invalid Email and/or Password.",
                                          message: "Please enter a valid email and password or choose to register for an account.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)

        }
        else{
            let myUrl = URL(string: "https://cgi.soic.indiana.edu/~team18/userLogin.php")
            
            var request = URLRequest(url: myUrl!)
            request.httpMethod = "POST"
            let postString = "email=\(_Email.text!)&password=\(_Password.text!)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
            
                if error != nil {
                    print("error=\(error)")
                    return
                }
            
                do {
                    //converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
//                    print("myJSON = \(myJSON)")
                    
                    
                    //parsing the json
                    if let parseJSON = myJSON {
                        //getting the json response - if login credentials invalid
                        
                        GlobalVariable.msg = (parseJSON["error"] as! String?)!
                        GlobalVariable.userType = (parseJSON["type"] as! String?)!
//                        print("Session Code = \(parseJSON["Session"]!)")
                        if GlobalVariable.userType == "employee"{
                            if let session_data = parseJSON["Session"] as? String {
                                let truckName = parseJSON["Name"] as? String!
                                let pwd = parseJSON["Password"] as? String!
                                let id = parseJSON["ID"]
                                let userType = parseJSON["type"]
                                
                                self.login_session = session_data
                                
                                let preferences = UserDefaults.standard
                                preferences.set(session_data, forKey: "session")
                                preferences.set(truckName, forKey: "name")
                                preferences.set(pwd, forKey: "password")
                                preferences.set(id, forKey: "id")
                                preferences.set(userType, forKey: "type")
                            }
                        } else {
                        if let session_data = parseJSON["Session"] as? String {
                                let firstName = parseJSON["Fname"] as? String!
                                let lastName = parseJSON["Lname"] as? String!
                                let pwd = parseJSON["Password"] as? String!
                                let id = parseJSON["ID"]
                                let userType = parseJSON["type"]
                                
                                self.login_session = session_data
                                
                                let preferences = UserDefaults.standard
                                preferences.set(session_data, forKey: "session")
                                preferences.set(firstName, forKey: "firstName")
                                preferences.set(lastName, forKey: "lastName")
                                preferences.set(pwd, forKey: "password")
                                preferences.set(id, forKey: "id")
                                preferences.set(userType, forKey: "type")
                            }
                        }
                        
                        print("user Type = \(GlobalVariable.userType)")
                        if GlobalVariable.msg == "true" {
                            GlobalVariable.existingEmail = true
                            OperationQueue.main.addOperation {
                                let alert = UIAlertController(title: "User not found.",
                                                              message: "Please enter your correct credentials.",
                                                              preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "OK",
                                                                 style: .cancel, handler: nil)
                                alert.addAction(cancelAction)
                                self.present(alert, animated: true)
                            }
                        } else {
                            //sends an alert to the main block's que to notify the user that they have successfully registered.
                            OperationQueue.main.addOperation {
                                
//                                print(GlobalVariable.userType)
                                OperationQueue.main.addOperation {
                                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                                    UserDefaults.standard.synchronize();
                                    self.performSegue(withIdentifier: "unwindToLoadscreen", sender: self)
//                                    print("type = \(GlobalVariable.userType)")
                                }
                            }
                            
                        }
                    }
                } catch {
                    print("Error is \(error)")
                }
            }
            task.resume()
        }
    }
}




