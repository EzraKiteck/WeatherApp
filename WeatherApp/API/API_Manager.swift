//
//  API_Manager.swift
//  WeatherApp
//
//  Created by Ezra Kiteck on 11/14/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct API_Manager {
    
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    //Call darksky for weather at location (latitude, longitude)
    static func getWeather(for location: Location, onComplete: @escaping (WeatherData?, Error?) -> Void) {
        //Variables
        let key = APIKeys.darkSkySecret
        let rootURL = "https://api.darksky.net/forecast/"
        
        //URL for Alamofire request
        let url = rootURL + key + "/" + String(location.longitude) + "," + String(location.latitude)
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let weatherData = WeatherData(json: json) {
                    onComplete(weatherData, nil)
                } else {
                    onComplete(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onComplete(nil, error)
            }
        }
        
    }
    
    static func geocode(address: String, onCompletion: @escaping (GeocodeingData?, Error?) -> Void) {
        
        let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let url = googleURL + address + "&key=" + APIKeys.googleKey
        

        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let geocodingData = GeocodeingData(json: json) {
                    onCompletion(geocodingData, nil) }
                else {
                    onCompletion(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onCompletion(nil, error)
            }
        }
        
    }
}
