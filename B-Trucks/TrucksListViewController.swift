//
//  TrucksViewController.swift
//  B-Trucks
//
//  Created by nickmastrandrea on 3/5/17.
//  Copyright © 2017 Wesley Van As. All rights reserved.
//
//
import UIKit
import CoreLocation
import MapKit

struct locationInfo {
    static var region: MKCoordinateRegion = MKCoordinateRegion()
    static var trucksInRange = [Trucks]()
}
//,CLLocationManagerDelegate
class TrucksListViewController: UIViewController
{
    
    @IBOutlet var tableView: UITableView!
    
    let preferences = UserDefaults.standard
    
    let manager = CLLocationManager()
    var region = MKCoordinateRegion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationInfo.trucksInRange = []
        
        let trucks = TIBTrucks.getAllTrucks()
        
        let preferences = UserDefaults.standard
        
        tableView.dataSource = self
        tableView.estimatedRowHeight = 376
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
        let uLat = Double(preferences.string(forKey: "userLatitude")!)!
        let uLon = Double(preferences.string(forKey: "userLongitude")!)!

        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(uLat, uLon)
        region = MKCoordinateRegionMake(myLocation, span)
        
        for truck in trucks {
            if isInRegion(region: region, coordinate: truck.location) {
                locationInfo.trucksInRange.append(truck)
            }
        }
        
//        print(trucks)

    }
    
    func isInRegion (region : MKCoordinateRegion, coordinate : CLLocationCoordinate2D) -> Bool {
        
        let center   = region.center;
        let northWestCorner = CLLocationCoordinate2D(latitude: center.latitude  - (region.span.latitudeDelta  / 2.0), longitude: center.longitude - (region.span.longitudeDelta / 2.0))
        let southEastCorner = CLLocationCoordinate2D(latitude: center.latitude  + (region.span.latitudeDelta  / 2.0), longitude: center.longitude + (region.span.longitudeDelta / 2.0))
        
        return (
            coordinate.latitude  >= northWestCorner.latitude &&
                coordinate.latitude  <= southEastCorner.latitude &&
                
                coordinate.longitude >= northWestCorner.longitude &&
                coordinate.longitude <= southEastCorner.longitude
        )
    }
    
}


extension TrucksListViewController :
    UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(locationInfo.trucksInRange.count)
        return locationInfo.trucksInRange.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrucksCell")! as! TruckTableViewCell
        let truck = locationInfo.trucksInRange[indexPath.row]
        
        
        cell.truck = truck
        
        cell.suggestionButton.tag = Int(cell.truckID)!
        cell.suggestionButton.addTarget(self, action: #selector(btnSuggestion_Click(sender:)), for: .touchUpInside)
        
        cell.menuButton.tag = Int(cell.truckID)!
        cell.menuButton.addTarget(self, action: #selector(btnMenu_Click(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func btnMenu_Click(sender: UIButton) {
        print("HEY!!!")
        preferences.removeObject(forKey: "passedID")
        preferences.set(sender.tag, forKey: "passedID")
        performSegue(withIdentifier: "viewMenu", sender: self)
    }
    
    func btnSuggestion_Click(sender: UIButton) {
        print("I WORK!!")
        preferences.removeObject(forKey: "passedID")
        preferences.set(sender.tag, forKey: "passedID")
        performSegue(withIdentifier: "makeSuggestion", sender: self)
    }
}
