//
//  Truck.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/5/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import Foundation
import MapKit

struct ownerTrucks {
    var id: String
    var name: String
}

struct listInfo {
    static var trucksOwned = [ownerTrucks]()
}

struct TrucksOwned {
    static func getAllTrucks() -> [ownerTrucks] {
        
        let preferences = UserDefaults.standard
        
        var listInfo = [ownerTrucks]()
        
        print("Step 1")
        
        let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/getOwnerTrucks.php")
        
        var request = URLRequest(url: myUrl!)

        request.httpMethod = "POST"
        print("type = \(preferences.string(forKey: "id")!)")
        let postString = "ownerID=\(preferences.string(forKey: "id")!)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        //gets the JSON
        let data = try! Data(contentsOf: myUrl!)
        
        //Saves the JSON as an array of dictionaries
        let trucks: NSArray = try! JSONSerialization.jsonObject(with: data, options: []) as! NSArray
        
        //        print(trucks)
        
        //Sets truckInfo to receive dictionaries in the format [String: AnyObject] to allow for indexing
        var truckInfo = [String: AnyObject]()
        
        //Loops through the dictionaries in the array and saves the information in a new array of dictionaries to allow for parsing.
        for truck in trucks {
            truckInfo = truck as! [String: AnyObject]
            
            let truckID = truckInfo["TruckID"]! as! String
            let truckName = truckInfo["Name"]! as! String
            
            let foodTruck = ownerTrucks(id: truckID, name: truckName)
            
            listInfo.append(foodTruck)
            print("Truck Added!")
        }
        
        return listInfo
        
    }
}
