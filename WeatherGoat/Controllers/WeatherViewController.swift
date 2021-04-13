//
//  WeatherViewController.swift
//  WeatherGoat
//
//  Created by Jon on 4/12/21.
//  Copyright © 2021 Jonathan Chua. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        let service = WeatherService()
        service.getWeather()
    }


}

