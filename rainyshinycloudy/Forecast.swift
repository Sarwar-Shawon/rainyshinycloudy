//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by sarwar shawon on 2/24/18.
//  Copyright © 2018 sarwar. All rights reserved.
//

import UIKit
import Alamofire
class Forecast {
    var _date : String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    var highTemp: String{
        if _highTemp == nil{
            _highTemp = ""
        }
        return _highTemp
    }
    var lowTemp: String{
        if _lowTemp == nil{
            _lowTemp = ""
        }
        return _lowTemp
    }
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let weather_main = weatherDict["main"] as? Dictionary<String,AnyObject>{
            
            if let min_temp = weather_main["temp_min"] as? Double{
                
                let _min_temp = round(min_temp - 273.15)
                self._lowTemp = "\(_min_temp)"
                
            }
            if let high_temp = weather_main["temp_max"] as? Double{
                
                let _high_temp = round(high_temp - 273.15)
                self._highTemp = "\(_high_temp)"
                
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String,AnyObject>]{
            if let w_type = weather[0]["main"] as? String{
                self._weatherType = w_type
            }
        }
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayoftheWeek()
            
            
            
        }
        
    }
    
}
extension Date{
    func dayoftheWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)

    }
}
