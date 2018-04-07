//
//  ViewController.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 04/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    var foursquare : FourSquare!
    
    var appkey = AppKey()
    
    var currentLUserLocation = CurrentUserLocation(lat: Double(60.1705171), lng: Double(24.935404))
    
    var locationManager = CLLocationManager()
    
    var waitaMoment = 0
    
    @IBOutlet weak var searchBox: UITextField!
    

    @IBAction func asdasd(_ sender: Any) {
        
        if(searchBox.text != "") {
            
            getData(searchVariable: searchBox.text)
            
             self.table.reloadData()

        }
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 1;
        
        if (waitaMoment > 0) {
        
        var foursquarecount = foursquare.response?.venues?.count as! Int
        
        if (foursquarecount > 0) {
            count = foursquare?.response?.venues?.count as! Int
        }

        }
        return (count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
         if (waitaMoment > 0) {
        
        cell.textLabel?.text = foursquare?.response?.venues?[indexPath.row].name as? String
 
        }
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude
        
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.01
        
        let lonDelta: CLLocationDegrees = 0.01
    
        currentLUserLocation.lat = latitude
        
        currentLUserLocation.lng = longitude
        
        
    }
    
    
    func getData(searchVariable: String?) {
        
        var secretKey = appkey.clientSecret
        var clientID = appkey.clientID
        var lng = currentLUserLocation.lng as! Double
        var lat = currentLUserLocation.lat as! Double
        
        var fixedVariable = searchVariable?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil) as! String
        
        
        
       //    var urlString = "https://api.foursquare.com/v2/venues/search?v=20171411&ll=60.1705171%2C24.935404&query=" + fixedVariable! + "&intent=checkin&radius=30000&client_id=" + secretKey + "&client_secret=" + clientID + ""
        
     var urlString = "https://api.foursquare.com/v2/venues/search?v=20171411&ll=\(lat)%2C\(lng)&query=\(fixedVariable)&intent=checkin&radius=30000&client_id=\(secretKey)&client_secret=\(clientID)"
        
        print(urlString)
       var fixedString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        guard let url = URL(string: urlString) else { return }
        


        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            if error != nil {
                print("error")
            }
            else
            {
                if let urlContent = data {
                    
                    do {
                    
                        self.foursquare =  try JSONDecoder().decode(FourSquare.self, from: urlContent)
                        
                        
                       //l print(self.foursquare.response?.venues?.count as! Int)
                        /*
                        for item in (self.foursquare.response?.venues)! {
                            print("---")
                            print(item.name)
                            print(item.location?.formattedAddress)
                            print("---")
                        }
                        
                        */
         
                        self.waitaMoment = 1
                       
                        
                    }
                    catch {
                        print("perkele")
                    }
                    
                    
                }
            }
        }
        
        task.resume()
         
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getData(searchVariable: "Helsinki")
         self.table.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

