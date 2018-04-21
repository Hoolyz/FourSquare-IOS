//
//  getVenuesData.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 21/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation


func getData(searchVariable: String?) {
    
  var appkey = AppKey()
    
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

