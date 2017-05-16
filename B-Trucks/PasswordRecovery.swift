//
//  PasswordRecovery.swift
//  B-Trucks
//
//  Created by Wesley Van As on 3/2/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class PasswordRecovery: UIViewController {
    
    @IBOutlet var userEmailEntry: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct GlobalVariable {
        static var msg = String()
        static var existingEmail = true
    }
    
    @IBAction func submitButtonPressed(_ sender: AnyObject) {
        let userEmail = userEmailEntry.text
        
        func validateEmail(candidate: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
        }
        let emailValidated = validateEmail(candidate: userEmailEntry.text!)
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
        if emailValidated { // passwordsMatch {
            let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/forgotPassword.php")
            
            var request = URLRequest(url: myUrl!)
            request.httpMethod = "POST"
            let postString = "email=\(userEmailEntry.text!)"
            
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
                        if GlobalVariable.msg == "Invalid email." {
                            //Sends an alert to the main block's que to notify the user that the email they registered with already exists in the database.
                            GlobalVariable.existingEmail = false
                            OperationQueue.main.addOperation {
                                let alert = UIAlertController(title: "Invalid email",
                                                              message: "Please enter the email that is associated with your account.",
                                                              preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "OK",
                                                                 style: .cancel, handler: nil)
                                alert.addAction(cancelAction)
                                self.present(alert, animated: true)
                            }
                        } else {
                            //sends an alert to the main block's que to notify the user that they have successfully registered.
                            OperationQueue.main.addOperation {
                                let alert = UIAlertController(title: "Email Sent",
                                                              message: "Your password has been sent to the email associated with your account.",
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
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
