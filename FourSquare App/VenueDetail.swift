//
//  VenueDetail.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 24/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation

class VenueDetail: Decodable {
    
    var response: VenueResponse?
    
    
    init(response: VenueResponse?) {
        self.response = response
    }
}

