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
   
    @IBAction func searchInput(_ sender: UITextField) {
        
        if(searchBox.text != "") {
         //    self.table.reloadData()
        
            getData(searchVariable: searchBox.text)
            
           self.table.reloadData()

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            self.table.reloadData()
        }
    }
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 1;
        
        if (waitaMoment > 0) {
        
        var foursquarecount = foursquare.response?.venues?.count as! Int
        
        if (foursquarecount >= 0) {
            count = foursquarecount
        }

        }
        return (count)
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath ) {

        if(indexPath.row != foursquare.response?.venues?.count){

            let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
   
            var detailLong: Double = foursquare?.response?.venues?[indexPath.row].location?.lng! as Double!
            var detailLat: Double = foursquare?.response?.venues?[indexPath.row].location?.lat! as Double!
            var detailName : String = foursquare!.response!.venues![indexPath.row].name! as String!
            
            detailViewController.detailLat = detailLat
            detailViewController.detailLong = detailLong
            detailViewController.currentLat = currentLUserLocation.lat!
            detailViewController.currentLong = currentLUserLocation.lng!
            detailViewController.detailName = (foursquare!.response!.venues![indexPath.row].name! as String )
            
            navigationController?.pushViewController(detailViewController, animated: true)

            self.table.reloadData()
      
        }
            
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        if (waitaMoment > 0 && indexPath.row >= 0 && indexPath.row <= (foursquare?.response?.venues?.count)!) {
      
            
            var distanceDetail = foursquare?.response?.venues?[indexPath.row].location?.distance
            
            var distanceDetailText = String(distanceDetail!) + "m"
            
        
        cell.textLabel?.text = foursquare?.response?.venues?[indexPath.row].name as? String
        cell.detailTextLabel?.text = distanceDetailText
 
        }
        
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude
        
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude
        
        currentLUserLocation.lat = latitude
        
        currentLUserLocation.lng = longitude
        
    }
    
    func getData(searchVariable: String?) {
        
        var secretKey = appkey.clientSecret
        var clientID = appkey.clientID
        var lng = currentLUserLocation.lng as! Double
        var lat = currentLUserLocation.lat as! Double
        
        var fixedVariable = searchVariable?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil) as! String

     var urlString = "https://api.foursquare.com/v2/venues/search?v=20171411&ll=\(lat)%2C\(lng)&query=\(fixedVariable)&intent=checkin&radius=30000&client_id=\(secretKey)&client_secret=\(clientID)"
    
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
                        
                        self.waitaMoment = 1
                
                    }
                    catch {
                        print("Error in URLSession / JSONDecoder")
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
        
        getData(searchVariable: "Pizza")
               self.table.reloadData()
  
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

