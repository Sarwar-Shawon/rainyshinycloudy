//
//  Location.swift
//  rainyshinycloudy
//
//  Created by sarwar shawon on 3/2/18.
//  Copyright © 2018 sarwar. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude: Double!
    var longitude: Double!
}
