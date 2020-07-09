//
//  WeatherDownloader.swift
//  WeatherCompanion
//
//  Created by Aleksandr  Babarikin  on 7/9/20.
//  Copyright © 2020 Aleksandr  Babarikin . All rights reserved.
//

import Foundation

protocol TodayWeather {
    func loadTodayWeather(cityName: String, completion: @escaping (Result<WeatherData, Error>) -> Void)
}

class TodayWeatherDownloader: TodayWeather {
    let session = URLSession.shared
    
    func loadTodayWeather(cityName: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName.trimmingCharacters(in: .whitespacesAndNewlines))&units=metric&appid=9c1a6ed01f570045b35c1aba861861a8") else {
            completion(.failure(CustomError(title: "Wrong url", description: "Wrong url description", code: 1)))
            return
        }
        
        let task = session.dataTask(with: url) { receivedData, resp, err in
            if let data = receivedData {
                do {
                    let decoder = JSONDecoder()
                    let decodedWeather = try decoder.decode(WeatherData.self, from: data)
                    completion(.success(decodedWeather))
                } catch {
                    completion(.failure(error))
                }
                
            }
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            let status = (resp as! HTTPURLResponse).statusCode
            guard status == 200 else {
                print(status)
                return
            }
        }
        task.resume()
    }
    
    deinit {
        session.invalidateAndCancel()
    }
}

protocol ErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct CustomError: ErrorProtocol {
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    private var _description: String

    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}
