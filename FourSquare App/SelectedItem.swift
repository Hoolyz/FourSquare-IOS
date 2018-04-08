//
//  SelectedItem.swift
//  FourSquare App
//
//  Created by Olli Sirviö on 08/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import Foundation

class SelectedItem {

var detailLat : Double
var detailLong : Double
var Name : String

init(detailLat: Double,detailLong : Double, Name : String) {
    self.detailLat = detailLat
    self.detailLong = detailLong
    self.Name = Name
}

}

