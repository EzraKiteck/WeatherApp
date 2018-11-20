//
//  GeocodeingData.swift
//  WeatherApp
//
//  Created by Ezra Kiteck on 11/19/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit
import SwiftyJSON

//Geocoding Data Model
class GeocodeingData {
    enum GeocodingDataKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    init(formattedAddress: String, latitude: Double, longitude: Double) {
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
    }
    
    //Convenience init
    convenience init?(json: JSON) {
        guard let results = json[GeocodingDataKeys.results.rawValue].array,
            results.count > 0 else {
                print("Something wrong with results")
                return nil
        }
        
        guard let formattedAddress = results[0][GeocodingDataKeys.formattedAddress.rawValue].string
            else {
                print("Something wrong with address")
                return nil
        }
        
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double
            else {
                print("Cant get latitude")
                return nil
        }
        
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double
            else {
                print("Cant get longitude")
                return nil
        }
        
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }

}
