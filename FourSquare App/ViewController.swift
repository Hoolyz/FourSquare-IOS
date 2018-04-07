//
//  ViewController.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 04/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var foursquare : FourSquare!
    
    var appkey = AppKey()
    
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
    
    
    func getData(searchVariable: String?) {
        
        var secretKey = appkey.clientSecret
        var clientID = appkey.clientID
        
       var fixedVariable = searchVariable?.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        var urlString = "https://api.foursquare.com/v2/venues/search?v=20171411&ll=60.1705171%2C24.935404&query=" + fixedVariable! + "&intent=checkin&radius=30000&client_id=" + secretKey + "&client_secret=" + clientID + ""
        
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
        
        
        getData(searchVariable: "Helsinki")
         self.table.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

