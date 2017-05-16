//
//  ViewController.swift
//  TechProfMock
//
//  Created by nickmastrandrea on 1/19/17.
//  Copyright © 2017 NickMastrandrea. All rights reserved.
//

import UIKit
import MapKit


class TagCustomAnnoation: MKPointAnnotation {
    //    var objectData: NSManagedObject!
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManger:CLLocationManager = CLLocationManager()
    var pinAnnotationView:MKPinAnnotationView!
    let mainMap = MKMapView()
    
    
    var pinLocations = [
        [
            "name":"roys",
            "location":CLLocationCoordinate2D(latitude: 39.166315, longitude: -86.527667)
        ],
        [
            "name":"hall",
            "location":CLLocationCoordinate2D(latitude: 39.180774, longitude: -86.521918)
        ]
    ]
    
    var region = MKCoordinateRegion()
    let preferences = UserDefaults.standard
    
    @IBOutlet var Settings: UIBarButtonItem!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        preferences.set(location.coordinate.latitude, forKey: "userLatitude")
        preferences.set(location.coordinate.longitude, forKey: "userLongitude")
        
        region = MKCoordinateRegionMake(myLocation, span)
        
        //mainMap.setRegion(region, animated: true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        
        Settings.target = self.revealViewController()
        Settings.action = #selector(SWRevealViewController.revealToggle(_:))
//
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    override func viewDidAppear(_ animated: Bool) {
        
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
            
            
            pinLocations.append(["ID": truckInfo["TruckID"]!, "name": truckInfo["Name"]!, "description": truckInfo["Description"]!, "foodType": truckInfo["FoodType"]!, "location" : truckLocation, "logo": truckInfo["Logo"]!])
        }
        
        let screenSize = self.view.frame
        self.mainMap.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        
        // adds an invisible padding to the map, so whatever you do it will treat the map as if it is smaller
        self.mainMap.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 60, right: 10)
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        mainMap.delegate = self
        
        mainMap.showsUserLocation = true
        self.view.addSubview(mainMap)
        
        for object in self.pinLocations {
            
            let buildingPin = TagCustomAnnoation()
            
            buildingPin.coordinate = object["location"] as! CLLocationCoordinate2D
            buildingPin.title = object["name"] as! String?
            buildingPin.subtitle = object["description"] as! String?
            
            mainMap.addAnnotation(buildingPin)
            
        }
        
        mainMap.showAnnotations(mainMap.annotations, animated: true)
        
//        //Zoom to user location
//        let noLocation = CLLocationCoordinate2D()
//        let viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
//        mainMap.setRegion(viewRegion, animated: false)
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations[0]
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.02, 0.02)
            let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
            preferences.set(location.coordinate.latitude, forKey: "userLatitude")
            preferences.set(location.coordinate.longitude, forKey: "userLongitude")
            
            region = MKCoordinateRegionMake(myLocation, span)
            mainMap.setRegion(region, animated: true)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "viewMenu", sender: view)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        pinView?.tintColor = UIColor.green
        pinView = MKAnnotationView(annotation:annotation, reuseIdentifier: reuseId)
        pinView?.image = UIImage(named: "Trucks")
        pinView?.canShowCallout = true
        let rightButton: AnyObject! = UIButton(type: .detailDisclosure)
        pinView!.rightCalloutAccessoryView = rightButton as? UIView
        
        
        
        return pinView
    }

    
}


