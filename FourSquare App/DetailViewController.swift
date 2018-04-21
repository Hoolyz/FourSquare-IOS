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
    
    @IBOutlet var mapView: MKMapView!
   
    var currentLong = Double()
    var currentLat = Double()
    
    var locationManager = CLLocationManager()
    
    var detailLong = Double()
    var detailLat = Double()
    var detailName = String()
    var id = String()
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        //var currentLUserLocation = CurrentUserLocation(lat: currentLat, lng: currentLong)
        let userLocation: CLLocation = locations[0]
        
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude
        
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude
        

        
        CurrentUserLocation.lat = latitude
        
        CurrentUserLocation.lng = longitude
        
           mapOverlay()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
       
        mapUpdate()
    }
    
    func mapUpdate() {
        
        let destinationLocation = CLLocationCoordinate2D(latitude: detailLat, longitude: detailLong )
    
        let destinationLocationMark = MKPlacemark(coordinate: destinationLocation)
     
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = detailName
        
        if let locationMark = destinationLocationMark.location {
            destinationAnnotation.coordinate = locationMark.coordinate
        }
        
        self.mapView.showAnnotations([destinationAnnotation], animated: false)
       
    
    }
    
    func mapOverlay(){
    
        let lat = CurrentUserLocation.lat
        
        let long = CurrentUserLocation.lng
        
        let destinationLocation = CLLocationCoordinate2D(latitude: detailLat, longitude: detailLong )
        let sourceLocation = CLLocationCoordinate2D(latitude: lat!, longitude: long! )
        
        let sourceLocationMark = MKPlacemark(coordinate: sourceLocation)
        let destinationLocationMark = MKPlacemark(coordinate: destinationLocation)
        
        let sourceMapItem = MKMapItem(placemark: sourceLocationMark)
        let destinationMapItem = MKMapItem(placemark: destinationLocationMark)
        
        let directionRequest = MKDirectionsRequest()
        
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            
            let route = response.routes[0]
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: false)
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
