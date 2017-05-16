//
//  Menu.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/29/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import Foundation

struct MenuItems {
    var id: String
    var title: String
    var subtitle: String
    var price: String
    
}

struct TIBMenuItems {
    static func getAllMenuItems() -> [MenuItems] {
        var listInfo:[MenuItems] = []
        
        let preferences = UserDefaults.standard
        
        let truckID = preferences.string(forKey: "passedID")!
        
        let url = URL(string: "http://cgi.soic.indiana.edu/~team18/getMenuItems.php")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        let postString = "TruckID=\(truckID)"
        
        print(postString)
        
        request.httpBody = postString.data(using: .utf8)
        
        //gets the JSON
        let data = try! Data(contentsOf: url!)
        
        //Saves the JSON as an array of dictionaries
        let menuItems: NSArray = try! JSONSerialization.jsonObject(with: data, options: []) as! NSArray
        
        //        print(trucks)
        
        //Sets truckInfo to receive dictionaries in the format [String: AnyObject] to allow for indexing
        var menuInfo = [String: AnyObject]()
        
        //Loops through the dictionaries in the array and saves the information in a new array of dictionaries to allow for parsing.
        for item in menuItems {
            menuInfo = item as! [String: AnyObject]
            
            let itemID = menuInfo["ItemID"] as! String
            let itemName = menuInfo["Name"]! as! String
            let itemDesc = menuInfo["Description"]! as! String
            let itemPrice = menuInfo["Price"]! as! String
            let menuItem = MenuItems(id: itemID, title: itemName, subtitle: itemDesc, price: itemPrice)
            
            listInfo.append(menuItem)
            print("Item Added!")
        }
        
        return listInfo
    }
}
