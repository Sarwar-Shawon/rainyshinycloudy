//
//  WeatherVc.swift
//  rainyshinycloudy
//
//  Created by sarwar shawon on 2/4/18.
//  Copyright © 2018 sarwar. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVc: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {


    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTemLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currenWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    var currentWeather: CurrentWeather!
    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        tableView.delegate = self
        tableView.dataSource = self

        
        currentWeather = CurrentWeather()

       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            currentLocation = locations[0]
//            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
//            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
//        print(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude )
//    }
    func locationAuthStatus(){

        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print(Location.sharedInstance.latitude , Location.sharedInstance.longitude)
            currentWeather.downloadWeatherDetails {
                self.downloadForecastDetails{
                    self.UpdateMainUi()
                }
            }
        }else{
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }

    }
    func downloadForecastDetails(completed: @escaping DownloadComplete){
        let forecastUrl = URL(string: FORECAST_URL)!
        Alamofire.request(forecastUrl).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]{
                    for obj in list{
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            
            let forecast = forecasts[indexPath.row]
            cell.configureell(forecast: forecast)
            return cell
        }else{
            return WeatherCell()
        }

    }
    func UpdateMainUi(){
        dateLabel.text = currentWeather.date
        currentTemLabel.text = "\(currentWeather.currentTemp)°"
        locationLabel.text = currentWeather.cityName
        currenWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    



}

