//
//  ApiManagerProtocol.swift
//  Weather
//
//  Created by Роман Важник on 06/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit

protocol APIManagerProtocol {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func getData(requst: URLRequest, complition: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
}

extension APIManagerProtocol {
    func getData(requst: URLRequest, complition: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        
        session.dataTask(with: requst) { (data, respons, error) in
            
            guard let HTTPResponse = respons as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Respons", comment: "")
                ]
                let error = NSError(domain: WeatherNetworkingDomain, code: 100, userInfo: userInfo)
                complition(nil, nil, error)
                return
            }
            guard let data = data else { return }
            
            switch HTTPResponse.statusCode {
            case 200:
                complition(data, HTTPResponse, nil)
            default:
                complition(nil, HTTPResponse, nil)
                print("We have response status \(HTTPResponse.statusCode)")
            }
        }.resume()
    }
}
