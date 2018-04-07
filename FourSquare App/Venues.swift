//
//  Venues.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 05/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation

class Venue: Decodable {
    
    var name: String?
    
    var location: Location?
    
    
    init(name: String? , location: Location?) {
        self.name = name
        self.location = location
    }
}
