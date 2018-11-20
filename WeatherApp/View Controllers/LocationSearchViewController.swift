//
//  LocationSearchViewController.swift
//  WeatherApp
//
//  Created by Ezra Kiteck on 11/19/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit

class LocationSearchViewController: UIViewController, UISearchBarDelegate {
    
    //IB Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Variables
    let apiManager = API_Manager()
    var geocodingData: GeocodeingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    //Handles Errors
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    
    //Retrieves GeocodingData using the weatherData function
    func retrieveGeocodingData(searchAddress: String) {
        API_Manager.geocode(address: searchAddress) {
            (geocodingData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            
            if let recievedData = geocodingData {
                self.geocodingData = recievedData
                self.retrieveWeatherData(latitude: recievedData.latitude, longitude: recievedData.latitude)
            } else {
                self.handleError()
                return
            }
        }
        
    }
    
    //Retrieves weather data for coordinates
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        API_Manager.getWeather(for: (latitude, longitude)) { (weatherData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            if let recievedData = weatherData {
                self.weatherData = recievedData
                self.performSegue(withIdentifier: "UnwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
            }
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveGeocodingData(searchAddress: searchAddress)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController,
        let recievedGeocodingData = geocodingData,
            let recievedWeatherData = weatherData {
            destinationVC.displayWeatherData = recievedWeatherData
            destinationVC.displayGeocodingData = recievedGeocodingData
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
