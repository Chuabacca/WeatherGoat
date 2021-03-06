//
//  WeatherViewModel.swift
//  WeatherGoat
//
//  Created by Jon on 4/12/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel {
    let service = WeatherService.shared
    var delegate: WeatherViewModelDelegate?

    var dailyForecast: [DayForecast] = []

    struct DayForecast {
        let date: String
        let minTemperature: Int
        let maxTemperature: Int
        let description: String
        let imageURL: String
    }

    func buildModel(lat: Double, lon: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"

        // Prevents multiple calls to getWeather when LocationManager sends multiple location updates.
        guard service.lat == nil else { return }

        service.lat = lat
        service.lon = lon

        // The model is responsible for calling the service so that the controller only needs to know about the model.
        service.getWeather() { [weak self] data in
            guard let self = self else { return }
            for day in self.service.dailyForecast {
                let dayForecast = DayForecast(
                    date: formatter.string(from: day.date),
                    minTemperature: Int(day.minTemperature),
                    maxTemperature: Int(day.maxTemperature),
                    description: day.weather[0].description,
                    imageURL: day.weather[0].imageURL
                )
                self.dailyForecast.append(dayForecast)
            }
            self.delegate?.didLoadViewModel()
            print(self.dailyForecast.description)
        }
    }
}

protocol WeatherViewModelDelegate {
    func didLoadViewModel()
}
