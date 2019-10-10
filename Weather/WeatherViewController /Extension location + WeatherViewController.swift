//
//  Extension location + WeatherViewController.swift
//  Weather
//
//  Created by Роман Важник on 09/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit
import CoreLocation

extension WeatherViewController: CLLocationManagerDelegate {
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        coordinates = Coordinates(latitude: location.coordinate.latitude,
                                  longitude: location.coordinate.longitude)
        //Get data from Api
        getWeather()
        
        // Fetch City from location
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                self.locationLabel.text = "City not defined"
                return
            } else if let city = placemark?.first?.locality  {
                self.locationLabel.text = city
            }
        }
    }
    
}
