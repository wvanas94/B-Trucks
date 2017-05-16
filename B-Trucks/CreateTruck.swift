//
//  CreateTruck.swift
//  B-Trucks
//
//  Created by Edward M. Dempsey Jr. on 3/30/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit
import Foundation

class addTruck: UIViewController {
    
    
    @IBOutlet var truckName: UITextField!
    @IBOutlet var truckDesc: UITextField!
    @IBOutlet var foodType: UITextField!
    @IBOutlet var truckEmail: UITextField!
    @IBOutlet var truckPhone: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
    }
    
    struct GlobalVariable {
        static var msg = String()
        static var existingEmail: Bool = false
    }
    
    @IBAction func createTruck(_ sender: AnyObject) {
        
        func validateName(candidate: String) -> Bool {
            let nameRegex = "[A-Z][A-Za-z -]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        let tNameValidated = validateName(candidate: truckName.text!)
        //print(fNameValidated)
        if tNameValidated == false {
            let alert = UIAlertController(title: "Invalid Truck Name",
                                          message: "Please enter a valid truck name.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        func validatetName(candidate: String) -> Bool {
            let nameRegex = "[A-Za-z -]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        let tDescValidated = validatetName(candidate: truckDesc.text!)
        if tDescValidated == false {
            let alert = UIAlertController(title: "Invalid Description",
                                          message: "Please enter a valid description.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        
        func validateEmail(candidate: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
        }
        let foodTypeValidated = validateName(candidate: foodType.text!)
        //print(emailValidated)
        
        if foodTypeValidated == false {
            let alert = UIAlertController(title: "Invalid Food Type",
                                          message: "Please enter a valid food type.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        func validatePhone(candidate: String) -> Bool {
            let phoneRegex = "((\\(\\d{3}\\) ?)|(\\d{3}-))?\\d{3}-\\d{4}"
            return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: candidate)
        }
        
        let phoneValidated = validatePhone(candidate: truckPhone.text!)
        
        if phoneValidated == false {
            let alert = UIAlertController(title: "Invalid Phone",
                                          message: "Please enter a valid phone number with the following format: (888) 888-8888",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        let emailValidated = validateEmail(candidate: truckEmail.text!)
        
        if emailValidated == false {
            let alert = UIAlertController(title: "Invalid Email",
                                          message: "Please enter a valid email address",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        
        if emailValidated && tNameValidated && tDescValidated && foodTypeValidated && phoneValidated { // passwordsMatch {
            let preferences = UserDefaults.standard
            let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/createTruck.php")
            
            var request = URLRequest(url: myUrl!)
            request.httpMethod = "POST"
            let postString = "truckName=\(truckName.text!)&truckDesc=\(truckDesc.text!)&foodType=\(foodType.text!)&truckPhone=\(truckPhone.text!)&truckEmail=\(truckEmail.text!)&ownerID=\(preferences.string(forKey: "id")!)&truckPassword=\(password.text!)"
            
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                //creating a string
                
                do {
                    //converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    //parsing the json
                    if let parseJSON = myJSON {
                        //getting the json response
                        GlobalVariable.msg = (parseJSON["message"] as! String?)!
                        if GlobalVariable.msg == "That email already exists" {
                            //Sends an alert to the main block's que to notify the user that the email they registered with already exists in the database.
                            GlobalVariable.existingEmail = true
                            OperationQueue.main.addOperation {
                                let alert = UIAlertController(title: "Email already exists",
                                                              message: "Please enter an email that is not already associated with a Truck's account.",
                                                              preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "OK",
                                                                 style: .cancel, handler: nil)
                                alert.addAction(cancelAction)
                                self.present(alert, animated: true)
                            }
                        } else {
                            //sends an alert to the main block's que to notify the user that they have successfully registered.
                            OperationQueue.main.addOperation {
                                let alert = UIAlertController(title: "Registered!",
                                                              message: "Thank you for registering.",
                                                              preferredStyle: .alert)
                                //Sends the user back to the login screen when they click OK on the alert.
                                let OKAction = UIAlertAction(title: "OK",
                                                             style: UIAlertActionStyle.default, handler: {
                                                                (_)in
                                                                self.performSegue(withIdentifier: "unwindToLogin", sender: self)
                                })
                                alert.addAction(OKAction)
                                self.present(alert, animated: true)
                            }
                            
                        }
                        
                        //print("response = \(type(of:GlobalVariable.msg))")
                        //print(GlobalVariable.msg)
                        //print(GlobalVariable.existingEmail)
                    }
                } catch {
                    print("Error =\(error)")
                }
            }
            
            task.resume()
        }
    }
}
