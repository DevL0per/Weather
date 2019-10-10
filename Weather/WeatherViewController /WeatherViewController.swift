//
//  WeatherViewController.swift
//  Weather
//
//  Created by Роман Важник on 06/10/2019.
//  Copyright © 2019 Роман Важник. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
     }
    
    var coordinates: Coordinates!
    var locationLabel = UILabel()
    let locationManager = CLLocationManager()
    
    private var iconImage: UIImageView! = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var pressureLabel = UILabel()
    private var humidityLabel = UILabel()
    private var temperatureLabel = UILabel()
    private var appearentTemperatureLabel = UILabel()
    
    private var refreshButton: UIButton!
    private var activityIndicator: UIActivityIndicatorView!
    
    private lazy var weatherManager = APIWeatherManager(apiKey: "048f56ba3bfbe5071076e03130702999")
    
    private var particlesView: ParticlesView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        
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
        
    }
    
    func getWeather() {
        weatherManager.fetchDataWeatherWith(coordinates: coordinates) { (APIResult) in
            self.activityIndicator.stopAnimating()
            switch APIResult {
            case .Success(let weather):
                self.updateInterfaceWith(weather)
            case .Error(let error as NSError):
                self.iconImage.image = UIImage(named: "unpredicted-icon")
                self.showAlertController(title: "Error", message: "\(error.localizedDescription)")
            }
        }
    }
    
    private func updateInterfaceWith(_ weather: CurrentWeater) {
        view.backgroundColor = weather.getBackgroundColor()
        pressureLabel.text = "\(weather.pressure)mm"
        humidityLabel.text = "\(weather.humidity)%"
        let temperature = weather.getTemperatureInСelsius(weather.temperature)
        temperatureLabel.text = "\(temperature)℃"
        iconImage.image = weather.getIconImage()
        let appearentTemperature = weather.getTemperatureInСelsius(weather.apparentTemperature)
        appearentTemperatureLabel.text = "Feels like: \(appearentTemperature)℃"
        particlesView.startAnimating(type: weather.icon)
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
        
        particlesView = ParticlesView()
        particlesView.frame.size.width = view.frame.width
        particlesView.frame.size.height = view.frame.height
        view.addSubview(particlesView)
        
        particlesView.translatesAutoresizingMaskIntoConstraints = false
        
        particlesView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        particlesView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        particlesView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        particlesView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
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
        
        mainStackView.topAnchor.constraint(equalTo: particlesView.topAnchor, constant: 10).isActive = true
        //mainStackView.topAnchor.constraint(equalTo: particlesView.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: particlesView.bottomAnchor).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: particlesView.leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: particlesView.rightAnchor).isActive = true
    }
    
}
