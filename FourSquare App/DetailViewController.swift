//
//  DetailViewController.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 08/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import UIKit
import MapKit


class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var map: MKMapView!
    
   //  var selectedItem : SelectedItem
    
    var currentLong = Double()
    var currentLat = Double()
    
   
    
    var locationManager = CLLocationManager()
    
    var detailLong = Double()
    var detailLat = Double()
    var detailName = String()
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
            var currentLUserLocation = CurrentUserLocation(lat: currentLat, lng: currentLong)
        let userLocation: CLLocation = locations[0]
        
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude
        
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.01
        
        let lonDelta: CLLocationDegrees = 0.01
        
        currentLUserLocation.lat = latitude
        
        currentLUserLocation.lng = longitude
        
 
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
     
        print("Second View")
        print( detailLat)
        print(detailLong)
        print(detailName)
         print("Second View")
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapUpdate()
    }
    
    func mapUpdate() {
        
            var currentLUserLocation = CurrentUserLocation(lat: currentLat, lng: currentLong)

            var lat = currentLUserLocation.lat as! Double
            
            var long = currentLUserLocation.lng as! Double
            
            let latDelta: CLLocationDegrees = 0.01
            
            let lonDelta: CLLocationDegrees = 0.01
            
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
            
            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long )
            
            let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
            
            map.setRegion(region, animated: true)
        
            
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}