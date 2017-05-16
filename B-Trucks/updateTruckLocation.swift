//
//  Test.swift
//  B-Trucks
//
//  Created by Edward M. Dempsey Jr. on 4/18/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class updateTruckLocation: UIViewController, CLLocationManagerDelegate {
    
    var switchState:String = ""
    let locationManager = CLLocationManager()
    
    @IBAction func signOut(_ sender: Any) {
        let preferences = UserDefaults.standard
        var login_session:String = ""
        login_session = preferences.string(forKey: "session")!
        
        preferences.removeObject(forKey: "session")
        preferences.removeObject(forKey: "name")
        preferences.removeObject(forKey: "password")
        preferences.removeObject(forKey: "id")
        preferences.removeObject(forKey: "type")
        preferences.removeObject(forKey: "userLongitude")
        preferences.removeObject(forKey: "userLatitude")
        preferences.removeObject(forKey: "userID")
        
        locationManager.stopUpdatingLocation()
        
        let tid:String = "1002"
        let myUrl1 = URL(string: "http://cgi.soic.indiana.edu/~team18/checkTruckStatus.php")
        
        var request1 = URLRequest(url: myUrl1!)
        request1.httpMethod = "POST"
        print("step5.555")
        let postString1 = "TruckID=\(tid)"
        print("step 5.2")
        request1.httpBody = postString1.data(using: String.Encoding.utf8)
        
        let task1 = URLSession.shared.dataTask(with: request1 as URLRequest){
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            do {
                //converting response to NSDictionary
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                print("step 5")
                
                //parsing the json
                if let parseJSON = myJSON {
                    //getting the json response
                    print("myJSON = \(parseJSON)")
                    
                    
                    print("Done")
                }
            } catch {
                print("Error=\(error)")
            }
        }
        print("Updated Location (off)")
        task1.resume()

        let myUrl = URL(string: "https://cgi.soic.indiana.edu/~team18/signOut.php")
        
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        let postString = "session=\(login_session)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            do {
            }
        }
        task.resume()
        
        OperationQueue.main.addOperation {
            for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                print("\(key) = \(value) \n")
            }
            self.performSegue(withIdentifier: "userToLogin", sender: self)
        }
    }

 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isAuthorizedtoGetUserLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation();
            locationManager.startUpdatingLocation()
            print("Updated Location")
        }

    }
    
    //if we have no permission to access user location, then ask user for permission.
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    //this method will be called each time when a user change his location access preference.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("User allowed us to access location")
            //do whatever init activities here.
        }
    }
    
    
    //this method is called by the framework on         locationManager.requestLocation();
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called")
        print("managerLat=\(manager.location!.coordinate.latitude)")
        print("managerLong=\(manager.location!.coordinate.longitude)")
        
        let tid:String = "1002"
        let myUrl = URL(string: "http://cgi.soic.indiana.edu/~team18/postTruckLocation.php")
        
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        print("step5.1")
        let postString = "TruckID=\(tid)&Longitude=\(String(manager.location!.coordinate.longitude))&Latitude=\(String(manager.location!.coordinate.latitude))"
        print("step 5.2")
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
                
                print("step 5")
                
                //parsing the json
                if let parseJSON = myJSON {
                    //getting the json response
                    print("myJSON = \(parseJSON)")
                    
                    print("Done")
                }
            } catch {
                print("Error=\(error)")
            }
        }
        
        task.resume()
        //store the user location here to firebase or somewhere
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }
    
}






