//
//  Location.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 05/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation

class Location: Decodable {
    var lat: Double?
    var lng: Double?
    var distance: Int?
    var formattedAddress: [String]?
    
    init(lat: Double?, lng: Double?, distance: Int?, formattedAddress: [String]?) {
        self.lat = lat
        self.lng = lng
        self.distance = distance
        self.formattedAddress = formattedAddress
    }
}
