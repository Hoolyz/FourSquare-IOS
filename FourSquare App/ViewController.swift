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
     
    var locationManager = CLLocationManager()
    
    //var currentLUserLocation = CurrentUserLocation()
    
    var waitaMoment = 0
    
    @IBOutlet weak var searchBox: UITextField!
    
    @IBOutlet weak var table: UITableView!
    
    @IBAction func searchInput(_ sender: UITextField) {
        
        if(searchBox.text != "") {
            self.table.allowsSelection = false
            getData(searchVariable: searchBox.text)
            
           self.table.reloadData()

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.foursquare?.response?.venues?.sort(by: { ($0.location?.distance)! < ($1.location?.distance)! })
            
            self.table.reloadData()
            self.table.allowsSelection = true
            
         
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          self.table.allowsSelection = false
        var count = 1;
        
        if (waitaMoment > 0) {
        
            let foursquarecount = (foursquare.response?.venues?.count)!
        
        if (foursquarecount >= 0) {
            count = foursquarecount
        }

        }
        return (count)
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath ) {

        if(indexPath.row != foursquare.response?.venues?.count){

            let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
   
            
            let detailLong: Double = (foursquare?.response?.venues?[indexPath.row].location?.lng! as Double?)!
            let detailLat: Double = (foursquare?.response?.venues?[indexPath.row].location?.lat! as Double?)!
            var _ : String = (foursquare!.response!.venues![indexPath.row].name! as String?)!
            
            detailViewController.detailLat = detailLat
            detailViewController.detailLong = detailLong
            detailViewController.id = (foursquare!.response!.venues![indexPath.row].id! as String )
            detailViewController.currentLat = CurrentUserLocation.lat!
            detailViewController.currentLong = CurrentUserLocation.lng!
            detailViewController.detailName = (foursquare!.response!.venues![indexPath.row].name! as String )
            
            navigationController?.pushViewController(detailViewController, animated: true)

            self.table.reloadData()
      
        }
            
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        if (waitaMoment > 0 && indexPath.row >= 0 && indexPath.row <= (foursquare?.response?.venues?.count)!) {
            
            
            let distanceDetail = foursquare?.response?.venues?[indexPath.row].location?.distance
            
          
            
            let distanceDetailText = String(distanceDetail!) + "m"
            
        
        cell.textLabel?.text = foursquare?.response?.venues?[indexPath.row].name
        cell.detailTextLabel?.text = distanceDetailText
 
        }
        
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude
        
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude
        
        
        CurrentUserLocation.lat = latitude
        
        CurrentUserLocation.lng = longitude
        
        
    }
    
    func getData(searchVariable: String?) {
        
        
        let secretKey = appkey.clientSecret
        let clientID = appkey.clientID
        let lng = CurrentUserLocation.lng!
        let lat = CurrentUserLocation.lat!
        
        let fixedVariable = searchVariable?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)

        let urlString = "https://api.foursquare.com/v2/venues/search?v=20171411&ll=\(lat)%2C\(lng)&query=\(String(describing: fixedVariable!))&intent=checkin&radius=30000&client_id=\(secretKey)&client_secret=\(clientID)"
    
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
        
        self.table.reloadData()
  
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

