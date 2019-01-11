//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by sarwar shawon on 2/23/18.
//  Copyright © 2018 sarwar. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {

    var _cityname: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!

    var date : String{
        if _date == nil{
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }

    var cityName : String{
        if _cityname == nil{
            _cityname = ""
        }
        return _cityname
    }
    var weatherType : String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    var currentTemp : Double{
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Almofire download
        let currentWeatherUrl = URL(string : CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherUrl).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value  as? Dictionary<String, AnyObject>{
               
                if let name = dict["name"] as? String{
                    self._cityname = name.capitalized
                                    }
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>]{
                    if let main = weather[0]["main"] as? String{
                        self._weatherType = main.capitalized
                                            }
                }
                if let tem = dict["main"] as? Dictionary<String,AnyObject>{
                    if let currentTem = tem["temp"] as? Double{
                        let cur_temp = currentTem
                        self._currentTemp = Double(cur_temp - 273.15 )
                    }
                }
                
            }
            completed()
        }
        
    }
    
 }


