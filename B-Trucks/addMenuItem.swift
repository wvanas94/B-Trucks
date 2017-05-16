//
//  RegisterUser.swift
//  B-Trucks
//
//  Created by Wesley Van As on 2/2/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit
import Foundation

class addMenuItem: UIViewController {
    
    struct GlobalVariable {
        static var msg = String()
        static var existingEmail: Bool = false
    }
    

    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemDescription: UITextField!
    @IBOutlet var itemPrice: UITextField!
    
    let preferences = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(updateOwnerInfo.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        
        func validateName(candidate: String) -> Bool {
            let nameRegex = "[A-Z][A-Za-z -]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        let nameValidated = validateName(candidate: itemName.text!)
        //print(fNameValidated)
        if nameValidated == false {
            let alert = UIAlertController(title: "Invalid Item Name",
                                          message: "Please enter a valid item name.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        let descValidated = validateName(candidate: itemDescription.text!)
        
        if descValidated == false {
            let alert = UIAlertController(title: "Invalid Description",
                                          message: "Please enter a valid description.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        func validatePrice(candidate: String) -> Bool {
            let nameRegex = "[$0-9.]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        let priceValidated = validatePrice(candidate: itemPrice.text!)
        
        if priceValidated == false {
            let alert = UIAlertController(title: "Invalid Price",
                                          message: "Please enter a valid price for your item.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        if nameValidated && descValidated && priceValidated {
        let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/addMenuItem.php")
        
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        let postString = "Name=\(itemName.text!)&Description=\(itemDescription.text!)&Price=\(itemPrice.text!)&TruckID=\(preferences.string(forKey: "passedID"))"
        
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
                if let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                    //getting the json response
                        //Sends an alert to the main block's que to notify the user that the email they registered with already exists in the database.
                    
                        //sends an alert to the main block's que to notify the user that they have successfully registered.
                        OperationQueue.main.addOperation {
                            let alert = UIAlertController(title: "Item Added!",
                                                          message: "",
                                                          preferredStyle: .alert)
                            //Sends the user back to the login screen when they click OK on the alert.
                            let OKAction = UIAlertAction(title: "OK",
                                                         style: UIAlertActionStyle.default, handler: {
                                                            (_)in
                                                            self.performSegue(withIdentifier: "unwindToViewMenus", sender: self)
                            })
                            alert.addAction(OKAction)
                            
                            self.present(alert, animated: true)
                        }
                        
                    }
                    
                    //print("response = \(type(of:GlobalVariable.msg))")
                    //print(GlobalVariable.msg)
                    //print(GlobalVariable.existingEmail)
            } catch {
                print(error)
            }
        }
        
        task.resume()
        }
    }
}

