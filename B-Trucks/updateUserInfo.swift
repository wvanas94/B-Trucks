//
//  updateUserInfo.swift
//  B-Trucks
//
//  Created by Wesley Van As on 3/30/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit
import Foundation

class updateUserInfo: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var password2: UITextField!
    
    let preferences = UserDefaults.standard
    
    var userID: String = ""
    
    struct GlobalVariable {
        static var msg = String()
        static var existingEmail: Bool = false
    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        userID = preferences.string(forKey: "id")!
//        
        self.firstName.text = preferences.string(forKey: "firstName")
        self.lastName.text = preferences.string(forKey: "lastName")
        self.password.text = preferences.string(forKey: "password")
        
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
        
        
        if fNameValidated && lNameValidated {
//            print("Validated!")
            let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/updateUser.php")
            
            var request = URLRequest(url: myUrl!)
            request.httpMethod = "POST"
            let postString = "fName=\(firstName.text!)&lName=\(lastName.text!)&password=\(password.text!)&id=\(userID)"
            
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
                        print("myJSON = \(parseJSON)")
                        GlobalVariable.msg = (parseJSON["message"] as! String?)!
                        
                        OperationQueue.main.addOperation {
                            
                            self.preferences.removeObject(forKey: "firstName")
                            self.preferences.set(self.firstName.text, forKey: "firstName")
                            self.preferences.removeObject(forKey: "lastName")
                            self.preferences.set(self.lastName.text, forKey: "lastName")
                            self.preferences.removeObject(forKey: "password")
                            self.preferences.set(self.password.text, forKey: "password")
                            
                            let alert = UIAlertController(title: "Saved!",
                                                          message: "Your new information has been saved!",
                                                          preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "OK",
                                                             style: .cancel, handler: {
                                                                (_)in
                                                                self.performSegue(withIdentifier: "userUnwindToMap", sender: self)
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
