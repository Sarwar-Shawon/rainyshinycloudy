//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by sarwar shawon on 2/23/18.
//  Copyright © 2018 sarwar. All rights reserved.
//

import Foundation
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat=\(Location.sharedInstance.latitude!)"
let LONGITude = "&lon=\(Location.sharedInstance.longitude!)"
let APP_ID = "&appid="
let API_KEYS = "9e0496776f63286755d917aa05bb8029"
typealias DownloadComplete = () -> ()
//23.728783, and the longitude is 90.393791
let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=9e0496776f63286755d917aa05bb8029"
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITude)\(APP_ID)\(API_KEYS)"
