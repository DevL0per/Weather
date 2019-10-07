//
//  APIWeatherManager .swift
//  Weather
//
//  Created by Роман Важник on 06/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

enum APIResult {
    case Success(CurrentWeater)
    case Error(Error)
}

enum ForecastType {
    case current(apiKey: String, coordinates: Coordinates)
    
    var baseURL: URL {
        return URL(string: "https://api.darksky.net")!
    }
    
    var path: String {
        switch self {
        case .current(let apiKey, let coordinates):
            return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        print(url?.absoluteString)
        return URLRequest(url: url!)
    }
}

final class APIWeatherManager: APIManagerProtocol {
    
    var sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
       return URLSession(configuration: sessionConfiguration)
    }()
    
    let apiKey: String
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchDataWeatherWith(coordinates: Coordinates, complitionHandler: @escaping (APIResult)->Void) {
        let request = ForecastType.current(apiKey: apiKey, coordinates: coordinates).request
        
        getData(requst: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    complitionHandler(.Error(error))
                }
                if let data = data {
                    do {
                        let weather = try JSONDecoder().decode(Weather.self, from: data)
                        complitionHandler(.Success(weather.currently))
                    } catch let error {
                        complitionHandler(.Error(error))
                    }
                } else {
                    let userInfo = [
                        NSLocalizedDescriptionKey: NSLocalizedString("Missing Data", comment: "")
                    ]
                    let error = NSError(domain: WeatherNetworkingDomain, code: 200, userInfo: userInfo)
                    complitionHandler(.Error(error))
                }
            }
        }
    }
    
}
