//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by sarwar shawon on 2/24/18.
//  Copyright © 2018 sarwar. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureell(forecast: Forecast){
        
        lowTemp.text = "\(forecast.lowTemp)°"
        highTemp.text = "\(forecast.highTemp)°"
        dayLabel.text = forecast.date
        weatherType.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }

}
