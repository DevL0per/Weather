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
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        coordinates = Coordinates(latitude: location.coordinate.latitude,
                                  longitude: location.coordinate.longitude)
    }
    
}
