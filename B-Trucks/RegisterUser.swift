//
//  RegisterUser.swift
//  B-Trucks
//
//  Created by Wesley Van As on 2/2/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit
import Foundation

class addUser: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var password2: UITextField!
    
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
    
    struct GlobalVariable {
        static var msg = String()
        static var existingEmail: Bool = false
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        
        
        func validateName(candidate: String) -> Bool {
            let nameRegex = "[A-Z][A-Za-z -]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        let fNameValidated = validateName(candidate: firstName.text!)
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
        
        let lNameValidated = validateName(candidate: lastName.text!)
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
        let emailValidated = validateEmail(candidate: email.text!)
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
        
        let validatedPassword = validatePassword(candidate: password.text!)
        
        if validatedPassword == false {
            let alert = UIAlertController(title: "Invalid Password",
                                          message: "Please enter a password containing at least one capital, one lowercase, one number and is between 8 and 14 characters.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
        
        if validatedPassword && password.text! != password2.text! {
                let alert = UIAlertController(title: "Passwords do not match",
                                              message: "Please make sure that both passwords match",
                                              preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK",
                                                 style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
    
    
        if emailValidated && fNameValidated && lNameValidated { // passwordsMatch {
            let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/createUser.php")
        
            var request = URLRequest(url: myUrl!)
            request.httpMethod = "POST"
            let postString = "fName=\(firstName.text!)&lName=\(lastName.text!)&email=\(email.text!)&password=\(password.text!)"
        
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
                                                              message: "Please enter an email that is not already associated with a User's account.",
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
                    print(error)
                }
            }

            task.resume()
        }
    }
}

