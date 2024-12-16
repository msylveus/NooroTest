//
//  WeatherTrackerApp.swift
//  WeatherTracker
//
//  Created by Myrline Sylveus on 12/14/24.
//

import SwiftUI

@main
struct WeatherTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(weatherVM: WeatherViewModel(weatherService: WeatherAPIServices()))
        }
    }
}
