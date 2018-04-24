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
    
    var id: String?
    
    var location: Location?
    
    var url : String?
    
    var description : String?
    
    var photos: Photos?
    
    var contact: Contact?
    
    
    init(name: String? , location: Location?, id: String?, url: String?, description: String?, photos: Photos?, contact: Contact?) {
        self.id = id
        self.name = name
        self.location = location
        self.url = url
        self.description = description
        self.photos = photos
        self.contact = contact
        
    }
}
