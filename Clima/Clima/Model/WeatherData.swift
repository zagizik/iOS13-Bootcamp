//
//  WeatherData.swift
//  Clima
//
//  Created by Александр Банников on 19.07.2020.
//  Copyright © 2020 Александр Банников. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
