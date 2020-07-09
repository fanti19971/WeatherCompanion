//
//  ViewModel.swift
//  WeatherCompanion
//
//  Created by Aleksandr  Babarikin  on 7/9/20.
//  Copyright © 2020 Aleksandr  Babarikin . All rights reserved.
//

import Foundation

enum TodayWeatherViewModelState {
    case loading(Bool)
    case todayWeatherReceived((Result<[TodayWeatherSection], Error>))
}

class TodayWeatherViewModel {
    let weatherService = TodayWeatherDownloader()
    
    var stateUpdated: ((TodayWeatherViewModelState) -> Void)?
    
    func getTodayWeather(cityName: String = "London") {
        stateUpdated?(.loading(true))
        weatherService.loadTodayWeather(cityName: cityName) { [weak self] result in
            DispatchQueue.main.async {
                self?.stateUpdated?(.loading(false))
                if case let Result.success(weather) = result {
                    guard let baseWeather = weather.weather.first else {
                        return
                    }
                    let main = UserMainWeatherInfo(
                        cityName: weather.name,
                        temp: "\(weather.main.temp)",
                        description: baseWeather.description
                    )
                    let temperature = UserTempInfo(mainWeatherInfo: weather.main)
                    
                    self?.stateUpdated?(
                        .todayWeatherReceived(.success([
                            TodayWeatherSection(title: "", cells: [TodayWeatherItem.main(main)]),
                            TodayWeatherSection(title: "Temperature details", cells: [TodayWeatherItem.temperature(temperature)]),
                            TodayWeatherSection(title: "Wind details", cells: [TodayWeatherItem.wind(weather.wind)])
                        ]))
                    )
                }
                if case let Result.failure(error) = result {
                    self?.stateUpdated?(.todayWeatherReceived(
                        .failure(error)
                        ))
                }
            }
        }
    }
    
    func searchTodayWeather(for cityName: String) {
        getTodayWeather(cityName: cityName)
    }
    
}

struct TodayWeatherSection {
    let title: String
    let cells: [TodayWeatherItem]
}

enum TodayWeatherItem {
    case main(UserMainWeatherInfo)
    case temperature(UserTempInfo)
    case wind(Wind)
}

struct UserMainWeatherInfo {
    var cityName: String
    var temp: String
    var description: String
}

struct UserTempInfo {
    init(mainWeatherInfo: MainWeatherData) {
        tempMin = "\(mainWeatherInfo.tempMin)"
        tempMax = "\(mainWeatherInfo.tempMax)"
        tempFeelsLike = "\(mainWeatherInfo.feelsLike)"
        pressure = "\(mainWeatherInfo.pressure)"
        humidity = "\(mainWeatherInfo.humidity)"
    }
    
    var tempMin: String
    var tempMax: String
    var tempFeelsLike: String
    var pressure: String
    var humidity: String
}
