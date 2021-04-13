//
//  WeatherViewController.swift
//  WeatherGoat
//
//  Created by Jon on 4/12/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDataSource, WeatherViewModelDelegate, CLLocationManagerDelegate {
    var model = WeatherViewModel()
    var locationManager = CLLocationManager()

    let weatherTableView = UITableView()
    let weatherCellIdentifier = "weatherCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        model.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Get Weather", style: .plain, target: self, action: #selector(didTapGetWeather))

        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherTableView.dataSource = self
        weatherTableView.register(WeatherCell.self, forCellReuseIdentifier: weatherCellIdentifier)
        weatherTableView.backgroundColor = .red
        view.addSubview(weatherTableView)

        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        view.backgroundColor = .blue
    }

    // MARK: - Use Cases
    @objc func didTapGetWeather() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        model.buildModel(lat: locationValue.latitude, lon: locationValue.longitude)
        print("locations = \(locationValue.latitude) \(locationValue.longitude)")
    }

    // MARK: - TableView data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.dailyForecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weatherCellIdentifier, for: indexPath) as! WeatherCell
        cell.setContent(model: model.dailyForecast[indexPath.row])
        return cell
    }

    // MARK: - ViewModel delegate methods
    func didLoadViewModel() {
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }

}


