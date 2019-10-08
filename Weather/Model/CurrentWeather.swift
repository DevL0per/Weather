//
//  CurrentWeather.swift
//  Weather
//
//  Created by Роман Важник on 06/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeater: Decodable {
    let temperature: Double
    let apparentTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: String
    
    func returnIconImage() -> UIImage {
        return UIImage(named: icon) ?? UIImage()
    }
}

struct Weather: Decodable {
    let currently: CurrentWeater
}
