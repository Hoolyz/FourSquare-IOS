//
//  DetailViewController.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 08/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import UIKit
import MapKit


class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var contact: UILabel!
    
    @IBOutlet weak var address: UILabel!
    

    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var url: UIButton!
    
    @IBOutlet var mapView: MKMapView!
   
    var currentLong = Double()
    var currentLat = Double()
    
     var appkey = AppKey()
        
    var locationManager = CLLocationManager()
    
    var detailLong = Double()
    var detailLat = Double()
    var detailName = String()
    var id = String()
    
    var venueDetail : VenueDetail!
    

    @IBAction func urlClick(_ sender: Any) {
        guard let btnUrl = URL(string: (self.venueDetail.response?.venue?.url)!) else { return }
        if (UIApplication.shared.canOpenURL(btnUrl)){
            UIApplication.shared.open(btnUrl, options: [:], completionHandler: nil)
        }
     self.url.titleLabel?.text = self.venueDetail.response?.venue?.url
    }
    
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
        getDetailData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.name.text = self.venueDetail.response?.venue?.name
            self.contact.text = self.venueDetail.response?.venue?.contact?.formattedPhone
            self.address.text = self.venueDetail.response?.venue?.location?.formattedAddress?[0]
            self.url.titleLabel?.text = self.venueDetail.response?.venue?.url
            
            if ((self.venueDetail.response?.venue?.photos?.groups?.count)! > 0) {
            let combinedImgUrl = (self.venueDetail.response?.venue?.photos?.groups?[0].items?[0].prefix)! + "500x500" + (self.venueDetail.response?.venue?.photos?.groups?[0].items?[0].suffix)!
            
            
            guard let imgUrl = URL(string: combinedImgUrl) else { return }
            
            let data = try? Data(contentsOf: imgUrl)
            
            
            self.imgView.image = UIImage(data: data!)
                self.imgView.contentMode = .scaleAspectFit
            }
            
        }
    }
    
    func getDetailData() {
	
        let secretKey = appkey.clientSecret
        let clientID = appkey.clientID
        
        let urlString = "https://api.foursquare.com/v2/venues/\(id)?v=20171411&&client_id=\(secretKey)&client_secret=\(clientID)"
      
        _ = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("error")
            }
            else
            {
                if let urlContent = data {
                    
                    do {
                       // print(urlContent)
                        self.venueDetail =  try JSONDecoder().decode(VenueDetail.self, from: urlContent)
                        

                        
                        
                    }
                    catch {
                        print("Error in URLSession / JSONDecoder")
                    }
                    
                    
                }
            }
        }
        
        task.resume()
        print(venueDetail)
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
