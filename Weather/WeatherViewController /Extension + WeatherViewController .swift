//
//  Extended + WeatherViewController .swift
//  Weather
//
//  Created by Роман Важник on 07/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit

extension WeatherViewController {
    
    func showAlertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
