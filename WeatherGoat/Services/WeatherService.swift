//
//  WeatherService.swift
//  WeatherGoat
//
//  Created by Jon on 4/12/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class WeatherService {
    // Create a singleton so we don't instantiate multiple instances of the service
    static let shared = WeatherService()

    // Structure of data we need for the app
    var dailyForecast: [DayForecast] = []

    struct DayForecast {
        let date: Date
        let minTemperature: Float
        let maxTemperature: Float
        let weather: [Weather]
        struct Weather {
            let description: String
            let imageURL: String
        }
    }
    
    // Structure of data from the API
    struct WeatherData: Codable {
        var daily: [DayData]
        struct DayData: Codable {
            var dt: Date
            var temp: Temp
            struct Temp: Codable {
                var min: Float
                var max: Float
            }
            var weather: [Weather]
            struct Weather: Codable {
                var description: String
                var icon: String
            }
        }
    }
    
    init() {}
    
    // hard code the url string for now
    let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&units=imperial&exclude=current,minutely,hourly,alerts&appid=802f1e7a53d3552f5406c1dcbec8eb22"
    
    func getWeather() {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Handle error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Handle server error: \(response.debugDescription)")
                return
            }
            guard let data = data else {
                print("Received no data from API.")
                return
            }
            self.decodeJSON(data)
        }
        task.resume()
    }
    
    // Separate diferent responsibilities into distinct functions
    func decodeJSON(_ data: Data) -> Void {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            self.mapWeatherData(weatherData)
            print(self.dailyForecast.description)
        } catch {
            print("Handle JSON decoding error: \(error)")
        }
    }
    
    func mapWeatherData(_ weatherData: WeatherData) -> Void {
        for dailyData in weatherData.daily {
            var weatherArray: [DayForecast.Weather] = []
            for weather in dailyData.weather {
                let weatherElement = DayForecast.Weather(
                    description: weather.description,
                    imageURL: "http://openweathermap.org/img/wn/\(weather.icon)@2x.png"
                )
                weatherArray.append(weatherElement)
            }
            let dailyForecast = DayForecast(
                date: dailyData.dt,
                minTemperature: dailyData.temp.min,
                maxTemperature: dailyData.temp.max,
                weather: weatherArray
                )
            self.dailyForecast.append(dailyForecast)
        }
    }
}
