//
//  WeatherModel.swift
//  WeatherCompanion
//
//  Created by Aleksandr  Babarikin  on 7/9/20.
//  Copyright © 2020 Aleksandr  Babarikin . All rights reserved.
//

import CoreLocation

struct WeatherData: Codable {

    private var _coordinate: Coordinate
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: _coordinate.lattitude, longitude: _coordinate.longitude)
        }
        set {
            _coordinate = Coordinate(lattitude: newValue.latitude, longitude: newValue.longitude)
        }
    }
    
    var weather: [Weather]
    var main: MainWeatherData
    var wind: Wind
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case _coordinate = "coord"
        case weather
        case main
        case wind
        case name
    }
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Coordinate: Codable {
    var lattitude: Double
    var longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case lattitude = "lat"
        case longitude = "lon"
    }
}

struct MainWeatherData: Codable {
    var temp: Float
    var feelsLike: Float
    var tempMin: Float
    var tempMax: Float
    var pressure: Float
    var humidity: Float
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Codable {
    var speed: Float
    var deg: Float
}

struct Clouds: Codable {
    var all: Float
}

struct SystemData: Codable {
    var type: Int
    var id: Int
    var message: Float?
    var country: String
    var sunrise: Int
    var sunset: Int
}

