//
//  UserLocation.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 08/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation

class CurrentUserLocation {
    
    var lat: Double?
    var lng: Double?
    
    init(lat: Double?, lng: Double?) {
        self.lat = lat
        self.lng = lng
    }
}
