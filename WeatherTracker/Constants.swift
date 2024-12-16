//
//  Constants.swift
//  WeatherTracker
//
//  Created by Myrline Sylveus on 12/14/24.
//

import Foundation
import SwiftUI

struct Constants {
    static let APIKey = "be81a97638a24e8287d42518241512"
    static let baseURL = "http://api.weatherapi.com/v1/current.json"
}

extension Color {
    static var blackishGray: Color {
        Color(red: 44.0/255.0, green: 44.0/255.0, blue: 44.0/255.0)
    }
    static var lightGray: Color {
        Color(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0)
    }
    
    static var mediumGray: Color {
        Color(red: 154.0/255.0, green: 154.0/255.0, blue: 154.0/255.0)
    }
    
    static var paleGrayishWhite: Color {
        Color(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0)
    }
}
