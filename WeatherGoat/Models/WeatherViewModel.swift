//
//  WeatherViewModel.swift
//  WeatherGoat
//
//  Created by Jon on 4/12/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

struct WeatherViewModel {
    var dailyForecast: [DayForecast] = []

    struct DayForecast {
        let date: String
        let minTemperature: Float
        let maxTemperature: Float
        let description: String
        let icon: UIImage
    }
}
