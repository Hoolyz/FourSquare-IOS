//
//  Response.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 05/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation

class Response: Decodable {
    
    var venues: [Venue]?
    
    init(venues: [Venue]?) {
        self.venues = venues
    }
}
