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
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var locationLabel = UILabel()
    private var pressureLabel = UILabel()
    private var humidityLabel = UILabel()
    private var temperatureLabel = UILabel()
    private var appearentTemperatureLabel = UILabel()
    
    private var refreshButton: UIButton!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private lazy var weatherManager = APIWeatherManager(apiKey: "048f56ba3bfbe5071076e03130702999")
    private let coordinates = Coordinates(latitude: 53.9, longitude: 27.5)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.3450980392, green: 0.4470588235, blue: 0.5137254902, alpha: 1)
        
        //Configure Labels
        configureLabel(for: locationLabel, sizeOffont: 15)
        configureLabel(for: pressureLabel, sizeOffont: 15)
        configureLabel(for: humidityLabel, sizeOffont: 15)
        configureLabel(for: temperatureLabel, sizeOffont: 60)
        configureLabel(for: appearentTemperatureLabel, sizeOffont: 15)
        
        //Configure refreshButton
        configureRefreshButton()
        // Configure ActivityIndicator
        configureActivityIndicator()
        
        //Create StackView for all Elements
        createStackView()
        
        //Get data from Api
        getWeather()
    }
    
    private func getWeather() {
        weatherManager.fetchDataWeatherWith(coordinates: coordinates) { (APIResult) in
            self.activityIndicator.stopAnimating()
            switch APIResult {
            case .Success(let weather):
                self.updateInterfaceWith(weather)
            case .Error(let error as NSError):
                self.showAlertController(title: "Error", message: "\(error.localizedDescription)")
            }
        }
    }
    
    private func updateInterfaceWith(_ weather: CurrentWeater) {
        pressureLabel.text = "\(weather.pressure)mm"
        humidityLabel.text = "\(weather.humidity)%"
        locationLabel.text = "Mink"
        temperatureLabel.text = "\(weather.temperature)℃"
        iconImage.image = weather.returnIconImage()
        appearentTemperatureLabel.text = "Feels like: \(weather.apparentTemperature)℃"
    }
    
    //MARK: - Config for elements
    private func configureLabel(for label: UILabel, sizeOffont: CGFloat) {
        label.font = UIFont.systemFont(ofSize: sizeOffont)
        label.text = ""
        label.textAlignment = .center
        label.textColor = .white
    }
    
    private func configureRefreshButton() {
        refreshButton = UIButton()
        refreshButton.setTitle("refresh", for: .normal)
        refreshButton.titleLabel?.textColor = .white
        refreshButton.addTarget(self, action: #selector(refreshButtonTarget), for: .touchUpInside)
    }
    
    @objc private func refreshButtonTarget() {
        activityIndicator.startAnimating()
        getWeather()
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
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
