//
//  WeatherAPIServices.swift
//  WeatherTracker
//
//  Created by Myrline Sylveus on 12/14/24.
//

import Foundation

protocol WeatherServiceAble {
    func getCurrentWeather(param: String) async throws -> Weather
}

struct WeatherAPIServices: WeatherServiceAble {
    
    func getCurrentWeather(param: String) async throws -> Weather {
        
        let urlString = "\(Constants.baseURL)?key=\(Constants.APIKey)&q=\(param)&aqi=no"
        
        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                let res = try JSONDecoder().decode(Weather.self, from: data)
                return res
            default:
                throw WeatherError.invalidResponse
            }
        } else {
            throw WeatherError.noResponse
        }
        
    }
}

enum WeatherError: Error {
    case invalidURL
    case invalidResponse
    case noResponse
}
