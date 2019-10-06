//
//  WeatherIconCases.swift
//  Weather
//
//  Created by Роман Важник on 06/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import Foundation
import UIKit

enum WeatherIconCases: String {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case unpredictedIcon = "unpredicted-icon"
    
    init(value: String) {
        switch value {
        case "clear-day": self = .clearDay
        case "clear-night": self = .clearNight
        case "rain": self = .rain
        case "snow": self = .snow
        case "sleet": self = .sleet
        case "wind": self = .wind
        case "fog": self = .fog
        case "cloudy": self = .cloudy
        case "partly-cloudy-day": self = .partlyCloudyDay
        case "partly-cloudy-night": self = .partlyCloudyNight
        default: self = .unpredictedIcon
        }
    }
    
    var iconImage: UIImage {
        return UIImage(named: self.rawValue)!
    }
    
}
