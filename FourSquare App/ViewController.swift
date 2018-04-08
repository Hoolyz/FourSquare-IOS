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
    
    var selectedItem : SelectedItem!
    
    var appkey = AppKey()
    
    var currentLUserLocation = CurrentUserLocation(lat: Double(60.1705171), lng: Double(24.935404))
    
    var locationManager = CLLocationManager()
    
    var waitaMoment = 0
    
    @IBOutlet weak var searchBox: UITextField!
   
    @IBAction func searchInput(_ sender: UITextField) {
        
        if(searchBox.text != "") {
         //    self.table.reloadData()
            print(searchBox.text)
            getData(searchVariable: searchBox.text)
            
           self.table.reloadData()

        }
         self.table.reloadData()
    }
    
    @IBAction func testi(_ sender: UITextField) {
               self.table.reloadData()
        print(testi)
    }
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 1;
        
        if (waitaMoment > 0) {
        
        var foursquarecount = foursquare.response?.venues?.count as! Int
        
        if (foursquarecount >= 0) {
            count = foursquare?.response?.venues?.count as! Int
        }

        }
        return (count)
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath ) {

        if(indexPath.row != foursquare.response?.venues?.count){

           // let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
               /*
            selectedItem.detailLat = (foursquare?.response?.venues?[indexPath.row].location?.lat)!
            selectedItem.detailLong = (foursquare?.response?.venues?[indexPath.row].location?.lng)!
            selectedItem.Name = (foursquare?.response?.venues?[indexPath.row].name)!
            
            self.performSegue(withIdentifier: "DetailView", sender: nil)
            
            if (segue.identifier == "DetailViewController"){
                let destVC:DetailViewController = segue.destination as! DetailViewController
                destVC.selectedItem = selectedItem
                
            }
            */
 self.table.reloadData()
        print(foursquare?.response?.venues?[indexPath.row].name)
        }
            
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
         if (waitaMoment > 0 && indexPath.row >= 0) {
      
            
            var distanceDetail = foursquare?.response?.venues?[indexPath.row].location?.distance
            
            var distanceDetailText = String(distanceDetail!) + "m"
            
            //print(distanceDetailText)
        
        cell.textLabel?.text = foursquare?.response?.venues?[indexPath.row].name as? String
        cell.detailTextLabel?.text = distanceDetailText
 
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
        
        getData(searchVariable: "Helsinki")
               self.table.reloadData()
  
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

