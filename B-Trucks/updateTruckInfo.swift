//
//  updateUserInfo.swift
//  B-Trucks
//
//  Created by Wesley Van As on 3/30/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit
import Foundation

class updateTruckInfo: UIViewController {
    
    @IBOutlet var truckName: UITextField!
    @IBOutlet var truckDescription: UITextField!
    @IBOutlet var truckFoodType: UITextField!
    @IBOutlet var truckPassword: UITextField!
    @IBOutlet var truckPassword2: UITextField!
    
    let preferences = UserDefaults.standard
    
    @IBAction func editTruckMenu(_ sender: Any) {
        performSegue(withIdentifier: "editMenuItems", sender: self)
    }
    @IBAction func backToTrucks(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToTruckView", sender: self)
    }
    
    struct GlobalVariable {
        static var msg = String()
        static var truckID = String()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalVariable.truckID = preferences.string(forKey: "passedID")!
        let firstUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/pullTruckInfo.php")
        var request1 = URLRequest(url: firstUrl!)
        request1.httpMethod = "POST"
        let postString1 = "truckID=\(GlobalVariable.truckID)"
        
        request1.httpBody = postString1.data(using: String.Encoding.utf8)
        
        let task1 = URLSession.shared.dataTask(with: request1 as URLRequest){
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            do {
                //converting response to NSDictionary
                let myJSON1 = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON1 = myJSON1 {
                    //getting the json response
                    self.preferences.removeObject(forKey: "tempTruckName")
                    self.preferences.set(parseJSON1["Name"] as! String?, forKey: "tempTruckName")
                    self.preferences.removeObject(forKey: "tempTruckDesc")
                    self.preferences.set(parseJSON1["Description"] as! String?, forKey: "tempTruckDesc")
                    self.preferences.removeObject(forKey: "tempFoodType")
                    self.preferences.set(parseJSON1["FoodType"] as! String?, forKey: "tempFoodType")
                    self.preferences.removeObject(forKey: "tempPassword")
                    self.preferences.set(parseJSON1["Password"] as! String?, forKey: "tempPassword")
                    }
                print("Done")
            } catch {
                print("Error=\(error)")
            }
        }
        
        task1.resume()
        
        
        //        truckDescription.Multiline = true
        
    }
    
    //    Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.truckName.text = self.preferences.string(forKey: "tempTruckName")
        self.truckPassword.text = self.preferences.string(forKey: "tempPassword")
        self.truckDescription.text = self.preferences.string(forKey: "tempTruckDesc")
        self.truckFoodType.text = self.preferences.string(forKey: "tempFoodType")
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        
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
        
        func validateDesc(candidate: String) -> Bool {
            let nameRegex = "[A-Za-z -]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        let tDescValidated = validateDesc(candidate: truckDescription.text!)
        //print(fNameValidated)
        if tDescValidated == false {
            let alert = UIAlertController(title: "Invalid Truck Description",
                                          message: "Please enter a valid truck description.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        func validatePassword(candidate: String) -> Bool {
            let passwordRegex = "(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{6,15}"
            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: candidate)
        }
        
        let validatedPassword = validatePassword(candidate: truckPassword.text!)
        
        if validatedPassword == false {
            let alert = UIAlertController(title: "Invalid Password",
                                          message: "Please enter a password containing at least one capital, one lowercase, one number and is between 8 and 14 characters.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        if validatedPassword && truckPassword.text! != truckPassword2.text! {
            
            let alert = UIAlertController(title: "Passwords do not match",
                                          message: "Please make sure that both passwords match",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        
        if tNameValidated && tDescValidated && validatedPassword {
            //            print("Validated!")
            let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/updateTruck.php")
            
            var request = URLRequest(url: myUrl!)
            request.httpMethod = "POST"
            let postString = "Name=\(truckName.text!)&Description=\(truckDescription.text!)&FoodType=\(truckFoodType.text!)&Password=\(truckPassword.text!)&id=\(GlobalVariable.truckID)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                do {
                    //converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    //parsing the json
                    if let parseJSON = myJSON {
                        //getting the json response
                        GlobalVariable.msg = (parseJSON["message"] as! String?)!
                        
                        OperationQueue.main.addOperation {
                            
                            
                            
                            let alert = UIAlertController(title: "Saved!",
                                                          message: "Your new information has been saved!",
                                                          preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "OK",
                                                             style: .cancel, handler: {
                                                                (_)in
                                                                self.performSegue(withIdentifier: "unwindToTruckView", sender: self)
                            })
                            alert.addAction(cancelAction)
                            self.present(alert, animated: true)
                        }
                        print("Done")
                    }
                } catch {
                    print("Error=\(error)")
                }
            }
            
            task.resume()
        }
    }
}

