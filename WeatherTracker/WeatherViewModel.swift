//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Myrline Sylveus on 12/14/24.
//

import Foundation

@Observable
final class WeatherViewModel {
    
    var weather: Weather?
    var paramValue = ""
    let weatherService: WeatherServiceAble?
    var showSearchResult = false
    var weatherErrorVal: Error?
    var showSpinner = false
    
    init(weatherService: WeatherServiceAble?) {
        self.weatherService = weatherService
    }
    
    func getWeatherServices(param: String) async throws {
        showSpinner = true
        do {
            weather = try await weatherService?.getCurrentWeather(param: param)
            showSpinner = false
        } catch {
            showSearchResult = false
            weather = nil
            showSpinner = false
            throw WeatherError.invalidResponse
        }
    }
    
    func searchCityWeather(param: String) {
        showSearchResult = true
        Task {
            do {
                try await getWeatherServices(param: param)
            } catch {
                weatherErrorVal = WeatherError.invalidResponse
            }
        }
    }
    
}
