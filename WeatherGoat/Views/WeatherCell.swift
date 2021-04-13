//
//  WeatherCell.swift
//  WeatherGoat
//
//  Created by Jon on 4/13/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    var model: WeatherViewModel.DayForecast?

    let weatherImage = UIImageView()
    let dateLabel = UILabel()
    let maxTemperatureLabel = UILabel()
    let minTemperatureLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.contentMode = .scaleAspectFill
        weatherImage.frame.size.height = 30.0
        weatherImage.frame.size.width = 30.0
        contentView.addSubview(weatherImage)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = .systemFont(ofSize: 18.0)
        contentView.addSubview(dateLabel)

        minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        minTemperatureLabel.font = .systemFont(ofSize: 12.0)
        contentView.addSubview(minTemperatureLabel)

        maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTemperatureLabel.font = .systemFont(ofSize: 12.0)
        contentView.addSubview(maxTemperatureLabel)

        NSLayoutConstraint.activate([
            weatherImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            dateLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 20.0),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),

            maxTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 20.0),
            maxTemperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10.0),

            minTemperatureLabel.leadingAnchor.constraint(equalTo: maxTemperatureLabel.trailingAnchor, constant: 20.0),
            minTemperatureLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10.0)
        ])
    }

    func setContent(model: WeatherViewModel.DayForecast) {
        self.model = model

        dateLabel.text = model.date
        maxTemperatureLabel.text = "High: \(String(model.maxTemperature))°"
        minTemperatureLabel.text = "Low: \(String(model.minTemperature))°"
    }
}
