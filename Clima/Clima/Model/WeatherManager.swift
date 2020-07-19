//
//  WeatherManager.swift
//  Clima
//
//  Created by Александр Банников on 19.07.2020.
//  Copyright © 2020 Александр Банников. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel)
    func didEndedWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=14d2b3cb30f7b262afd04c0b1988494f&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetnchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetnchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //1 create url
        if let url = URL(string: urlString) {
            //2 creating url session
            let session = URLSession(configuration: .default)
            // 3 give session a task
            let task = session.dataTask(with: url) { (data, response, error ) in
                
                if error != nil {
                    self.delegate?.didEndedWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(weatherManager: self, weather: weather)
                    }
                }
            }
            //4 start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            print(weather.tempetatureString)
            return weather
        } catch {
            delegate?.didEndedWithError(error: error)
            return nil
        }
    }
}
