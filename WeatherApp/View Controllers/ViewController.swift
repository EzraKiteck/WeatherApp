//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ezra Kiteck on 11/14/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    //IB Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherIcon: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    
    //Gives location
    var displayGeocodingData: GeocodeingData! {
        didSet {
            locationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    //Shows current weather data
    var displayWeatherData: WeatherData! {
        didSet {
            weatherIcon.text = displayWeatherData.condition.icon
            currentTemperature.text = "\(displayWeatherData.temperature)º"
            highTemp.text = "\(displayWeatherData.highTemperature)º"
            lowTemp.text = "\(displayWeatherData.lowTemperature)º"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Location
        let longitude = 37.8267
        let latitude = -122.4233
        
        //Gets the weather
        API_Manager.getWeather(for: (latitude, longitude)) { weatherData, error in
            if let receivedData = weatherData {
                self.displayWeatherData = receivedData
            }
            
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func setupDefaultUI() {
        
    }
    
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) { }
}

