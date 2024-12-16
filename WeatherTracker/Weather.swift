//
//  Weather.swift
//  WeatherTracker
//
//  Created by Myrline Sylveus on 12/14/24.
//

import Foundation

struct Weather: Decodable {
    let location: Location
    let current: CurrentWeather
    
}

struct Location: Decodable {
   let name: String
   let region: String
   let country: String
   let lat: Double
   let lon: Double
   let localtime: String
}

struct CurrentWeather: Decodable {
    let tempC: Double
    let tempF: Double
    let condition: CurrentCondition
    let humidity: Int
    let feelsLikeC: Double
    let feelsLikeF: Double
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
        case humidity
        case feelsLikeC = "feelslike_c"
        case feelsLikeF = "feelslike_f"
        case uv
        
    }
}

struct CurrentCondition: Decodable {
    let text: String
    private let icon: String
    let code: Int
    
    var imageURL: String {
        return icon.replacingOccurrences(of: "//", with: "http://")
    }
}
