//
//  WeatherTrackerTests.swift
//  WeatherTrackerTests
//
//  Created by Myrline Sylveus on 12/14/24.
//

import Testing
@testable import WeatherTracker
import Foundation

struct MockWeatherService: WeatherServiceAble {
    enum ResponseType {
        case success
        case failure
    }
    
    let param: String
    let type: ResponseType
    
    func getCurrentWeather(param: String) async throws -> Weather {
        var fileName = ""
        
        switch type {
        case .success:
            fileName = "WeatherSuccess"
        case .failure:
            fileName = "WeatherFailure"
        }
        guard let data = JSONReader().readJSON(fileName: fileName) else {
            throw WeatherError.invalidResponse
        }
    
        let res = try JSONDecoder().decode(Weather.self, from: data)
        return res
    }
}

struct WeatherTrackerTests {

    @Test func testGetSuccess() async throws {
        let viewModel = WeatherViewModel(weatherService: MockWeatherService(param: "", type: .success))
        try await viewModel.getWeatherServices(param: "")
        #expect(viewModel.weather != nil)
    }

    @Test func testGetFailure() async {
        let viewModel = WeatherViewModel(weatherService: MockWeatherService(param: "", type: .failure))
        do {
            try await viewModel.getWeatherServices(param: "")
        } catch {
            #expect(viewModel.weather == nil)
            #expect(viewModel.showSearchResult == false)
        }
    }
}
