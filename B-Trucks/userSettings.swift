//
//  userSettings.swift
//  B-Trucks
//
//  Created by Edward M. Dempsey Jr. on 4/5/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit
import Foundation

class userSettings: UIViewController {
    
    @IBOutlet var FirstName: UITextField!
    @IBOutlet var LastName: UITextField!
    @IBOutlet var Email: UITextField!
    @IBOutlet var Phone: UITextField!
    @IBOutlet var Password: UITextField!
    @IBOutlet var Password2: UITextField!
    
    
    let userID = UserDefaults.standard.object(forKey: "userID") as! String
    
    
    struct GlobalVariable {
        static var msg = String()
        static var pWord = String()
        static var pWord2 = String()
    }
    
    
    @IBAction func submit(_ sender: AnyObject) {
        
        
        
        print("part 2")
        
        func validateName(candidate: String) -> Bool {
            let nameRegex = "[A-Z][A-Za-z -]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        var fNameValidated = validateName(candidate: FirstName.text!)
        
        // allows for empty string to be posted
        if FirstName.text! == "" {
            fNameValidated = true
            print("part 3")
        }
        
        //print(fNameValidated)
        if fNameValidated == false {
            let alert = UIAlertController(title: "Invalid First Name",
                                          message: "Please enter a valid first name.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        var lNameValidated = validateName(candidate: LastName.text!)
        
        // allows for empty string to be posted
        if LastName.text! == "" {
            lNameValidated = true
        }
        
        if lNameValidated == false {
            let alert = UIAlertController(title: "Invalid Last Name",
                                          message: "Please enter a valid last name.",
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
        var emailValidated = validateEmail(candidate: Email.text!)
        
        // allows for empty string to be posted
        if Email.text! == "" {
            emailValidated = true
        }
        //print(emailValidated)
        
        if emailValidated == false {
            let alert = UIAlertController(title: "Invalid Email",
                                          message: "Please enter a valid email address.",
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
        
        var validatedPassword = validatePassword(candidate: Password.text!)
    
        // allows for empty string to be posted
        if Password.text! == "" && Password2.text! == "" {
            validatedPassword = true
            GlobalVariable.pWord = "x"
            GlobalVariable.pWord2 = "x"
            print("part 5")
        } else {
            GlobalVariable.pWord = Password.text!
            GlobalVariable.pWord2 = Password2.text!
        }
        
        if validatedPassword == false {
            let alert = UIAlertController(title: "Invalid Password",
                                          message: "Please enter a password containing at least one capital, one lowercase, one number and is between 8 and 14 characters.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        
                if validatedPassword && GlobalVariable.pWord == GlobalVariable.pWord2 {
                    var passwordsMatch = true
                }
                else {
                    let alert = UIAlertController(title: "Passwords do not match",
                                                  message: "Please make sure that both passwords match",
                                                  preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK",
                                                     style: .cancel, handler: nil)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true)
                }
        
        func validatePhone(candidate: String) -> Bool {
            let phoneRegex = "\\d{10}"
            return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: candidate)
        }
        
        var phoneValidated = validatePhone(candidate: Phone.text!)
        
        // allows for empty string to be posted
        if Phone.text! == "" {
            phoneValidated = true
        }
        
        if phoneValidated == false {
            let alert = UIAlertController(title: "Invalid Phone",
                                          message: "Please enter a valid phone number with the following format: 8888888888",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        
        print("part 6")
        if emailValidated && fNameValidated && lNameValidated && phoneValidated {
            
            let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/userSettings.php")
            
            var request = URLRequest(url: myUrl!)
            request.httpMethod = "POST"
            let postString = "fName=\(FirstName.text!)&lName=\(LastName.text!)&email=\(Email.text!)&phone=\(Phone.text!)&password=\(GlobalVariable.pWord)&userid=\(userID)"
            
            print(postString)
            print("part 7")
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                
                print("part 4")
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                // creating a string
                
                do {
                    //converting response to NSDictionary
                    let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    print("part 8")
                    //parsing the json
                    if let parseJSON = myJSON {
                        //getting the json response
                        GlobalVariable.msg = (parseJSON["message"] as! String?)!
                        print("part 9")
                        if GlobalVariable.msg != "Changes successfully made!" {
                            //Sends an alert to the main block's que to notify the user that the email they registered with already exists in the database.
                            
                            OperationQueue.main.addOperation {
                                let alert = UIAlertController(title: "Changes Unsuccessful",
                                                              message: "Changes were not successfully saved. Please try again.",
                                                              preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "OK",
                                                                 style: .cancel, handler: nil)
                                alert.addAction(cancelAction)
                                self.present(alert, animated: true)
                            }
                        } else {
                            //sends an alert to the main block's que to notify the user that they have successfully registered.
                            OperationQueue.main.addOperation {
                                let alert = UIAlertController(title: "Changes Successfully Made!",
                                                              message: "Your changes will be reflected in our system immediately",
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
                    print(error)
                }
            }
            task.resume()
        }
    }
}
