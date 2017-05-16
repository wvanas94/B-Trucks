//
//  FoodRecommendations.swift
//  B-Trucks
//
//  Created by Wesley Van As on 3/2/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import UIKit

class FoodRecommendations: UIViewController {

    @IBOutlet var suggestionName: UITextField!
    @IBOutlet var suggestionDescription: UITextField!
    var userID = UserDefaults.standard.string(forKey: "id")
    var truckID = "1002"
    
    override func viewDidLoad() {
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
    
    @IBAction func sendSuggestion(_ sender: AnyObject) {
        
        func validateName(candidate: String) -> Bool {
            let nameRegex = "[A-Za-z -]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        let nameValidated = validateName(candidate: suggestionName.text!)
        //print(fNameValidated)
        if nameValidated == false {
            let alert = UIAlertController(title: "Invalid Recommendation Name",
                                          message: "Please enter a valid recommendation name.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }

        func validateSug(candidate: String) -> Bool {
            let nameRegex = "[A-Za-z -.]+"
            return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        }
        
        let sugValidated = validateSug(candidate: suggestionDescription.text!)
        //print(fNameValidated)
        if sugValidated == false {
            let alert = UIAlertController(title: "Invalid Suggestion",
                                          message: "Please enter a valid suggestion.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }

        if nameValidated && sugValidated {
        let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/itemRecommendation.php")
        
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        let postString = "userID=\(userID)&truckID=\(truckID)&title=\(suggestionName.text!)&description=\(suggestionDescription.text!)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
    
        
        }
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
