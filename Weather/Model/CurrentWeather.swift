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
}

extension CurrentWeater {
    
    func getIconImage() -> UIImage {
        return UIImage(named: icon) ?? UIImage()
    }
    
    func getBackgroundColor() -> UIColor {
        switch icon {
        case "clearDay", "cloudy", "partlyCloudyDay": return #colorLiteral(red: 0.3697364397, green: 0.6474654433, blue: 1, alpha: 1)
        case "clearNight", "partlyCloudyNight": return #colorLiteral(red: 0.09491928347, green: 0.07393044397, blue: 0.09852871193, alpha: 1)
        case "fog", "rain", "sleet", "snow", "wind": return #colorLiteral(red: 0.3450980392, green: 0.4470588235, blue: 0.5137254902, alpha: 1)
        default: return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    func getTemperatureInСelsius(_ fahrenheit: Double) -> Int {
        return Int((fahrenheit-32) * 5/9)
    }
}

struct Weather: Decodable {
    let currently: CurrentWeater
}
