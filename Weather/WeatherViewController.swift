//
//  WeatherViewController.swift
//  Weather
//
//  Created by Роман Важник on 06/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var iconImage: UIImageView! = {
        let image = UIImageView()
        image.image = UIImage(named: "sun")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var locationLabel = UILabel()
    private var pressureLabel = UILabel()
    private var humidityLabel = UILabel()
    private var temperatureLabel = UILabel()
    private var appearentTemperatureLabel = UILabel()
    
    private var refreshButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.4470588235, blue: 0.5137254902, alpha: 1)
        
        configureLabel(for: locationLabel, text: "kek", sizeOffont: 15)
        configureLabel(for: pressureLabel, text: "kek", sizeOffont: 15)
        configureLabel(for: humidityLabel, text: "kek", sizeOffont: 15)
        configureLabel(for: temperatureLabel, text: "kek", sizeOffont: 60)
        configureLabel(for: appearentTemperatureLabel, text: "kek", sizeOffont: 15)
        
        configureRefreshButton()
        createStackView()
    }

    private func configureLabel(for label: UILabel, text: String, sizeOffont: CGFloat) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: sizeOffont)
        label.textAlignment = .center
        label.textColor = .white
    }
    
    private func configureRefreshButton() {
        refreshButton = UIButton()
        refreshButton.setTitle("refresh", for: .normal)
        refreshButton.titleLabel?.textColor = .white
    }
    
    private func createStackView() {
        
        let mainStackView = UIStackView()
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 5
        
        //StackView for pressureLabel and humidityLabel
        let stackViewForLabels = UIStackView()
        stackViewForLabels.axis = .horizontal
        stackViewForLabels.alignment = .center
        stackViewForLabels.distribution = .fillEqually
        
        stackViewForLabels.addArrangedSubview(pressureLabel)
        stackViewForLabels.addArrangedSubview(humidityLabel)
        
        //add elements on mainStackView
        mainStackView.addArrangedSubview(locationLabel)
        mainStackView.addArrangedSubview(iconImage)
        mainStackView.addArrangedSubview(stackViewForLabels)
        mainStackView.addArrangedSubview(temperatureLabel)
        mainStackView.addArrangedSubview(appearentTemperatureLabel)
        mainStackView.addArrangedSubview(refreshButton)
        
        //set constraints on mainStackView
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}
