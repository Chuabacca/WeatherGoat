//
//  WeatherViewController.swift
//  WeatherGoat
//
//  Created by Jon on 4/12/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource, WeatherViewModelDelegate {
    var model = WeatherViewModel()

    let weatherTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        model.delegate = self

        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherTableView.dataSource = self
        weatherTableView.register(UITableViewCell.self, forCellReuseIdentifier: "weatherCell")
        weatherTableView.backgroundColor = .red
        view.addSubview(weatherTableView)

        NSLayoutConstraint.activate([
            weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            weatherTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weatherTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        view.backgroundColor = .blue
        model.buildModel()
    }

    // MARK: - TableView data source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.dailyForecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        cell.textLabel!.text = "[\(indexPath.row)] \(model.dailyForecast[indexPath.row].date)"
        return cell
    }

    // MARK: - ViewModel delegate methods
    func didLoadViewModel() {
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }

}


