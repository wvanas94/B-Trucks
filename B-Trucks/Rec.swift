//
//  Rec.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import Foundation


struct Rec {
    var title: String
    var description: String
    
}

struct TIBRecs {
    static func getAllRecs() -> [Rec] {
        
        let preferences = UserDefaults.standard
        
        var listInfo = [Rec]()
        
        let truckID = preferences.string(forKey: "passedID")!
        
        let url = URL(string: "http://cgi.soic.indiana.edu/~team18/getTruckSuggestions.php")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        let postString = "TruckID=\(truckID)"
        
        print(postString)
        
        request.httpBody = postString.data(using: .utf8)
        
        //gets the JSON
        let data = try! Data(contentsOf: url!)
        
        //Saves the JSON as an array of dictionaries
        let recs: NSArray = try! JSONSerialization.jsonObject(with: data, options: []) as! NSArray
        
        print(recs)
        //        print(trucks)
        
        //Sets truckInfo to receive dictionaries in the format [String: AnyObject] to allow for indexing
        var recInfo = [String: AnyObject]()
        
        //Loops through the dictionaries in the array and saves the information in a new array of dictionaries to allow for parsing.
        for item in recs {
            recInfo = item as! [String: AnyObject]
            
            let recTitle = recInfo["Title"]! as! String
            let recDescription = recInfo["Description"]! as! String
            let foodRec = Rec(title: recTitle, description: recDescription)
            
            listInfo.append(foodRec)
            print("Rec Added!")
        }
        
        return listInfo
    }
}
