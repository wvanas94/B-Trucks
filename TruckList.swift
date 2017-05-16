//
//  Truck.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/5/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

struct Trucks {
    var id: String
    var name: String
    var info: String
    var foodType: String
    var location: CLLocationCoordinate2D
    var imageName: String
}


struct TIBTrucks {
    
    static func getAllTrucks() -> [Trucks] {
        
        var listInfo:[Trucks] = []
        
        let url = URL(string: "http://cgi.soic.indiana.edu/~team18/getTruckLocations.php")!
        
        //gets the JSON
        let data = try! Data(contentsOf: url)
        
        //Saves the JSON as an array of dictionaries
        let trucks: NSArray = try! JSONSerialization.jsonObject(with: data, options: []) as! NSArray
        
        //        print(trucks)
        
        //Sets truckInfo to receive dictionaries in the format [String: AnyObject] to allow for indexing
        var truckInfo = [String: AnyObject]()
        
        //Loops through the dictionaries in the array and saves the information in a new array of dictionaries to allow for parsing.
        for truck in trucks {
            truckInfo = truck as! [String: AnyObject]
            let truckLatitude = (truckInfo["Latitude"] as! NSString).doubleValue
            let truckLongitude = (truckInfo["Longitude"] as! NSString).doubleValue
            let truckLocation = CLLocationCoordinate2D(latitude: truckLatitude, longitude: truckLongitude)
            
            let truckID = truckInfo["TruckID"]! as! String
            let truckName = truckInfo["Name"]! as! String
            let information = truckInfo["Description"]! as! String
            let truckFoodType = truckInfo["FoodType"]! as! String
            let truckImageName = "donerkebab"
            let foodTruck = Trucks(id: truckID, name: truckName, info: information, foodType: truckFoodType, location: truckLocation, imageName: truckImageName)
        
            listInfo.append(foodTruck)
            print("Truck Added!")
        }
        
        return listInfo

    }
}
