		//
//  Items.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 24/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation

class Items : Decodable {
    
    var prefix : String?
    var suffix : String?
    
    init(prefix: String?, suffix: String?) {
        self.prefix = prefix
        self.suffix = suffix
    }
            
}
