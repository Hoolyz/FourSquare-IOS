//
//  FourSquare.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 05/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation

class FourSquare: Decodable {
    
    var response: Response?
    
    
    init(response: Response?) {
        self.response = response
    }
}

