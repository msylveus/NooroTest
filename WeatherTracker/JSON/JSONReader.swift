//
//  JSONReader.swift
//  WeatherTracker
//
//  Created by Myrline Sylveus on 12/15/24.
//

import Foundation

struct JSONReader {
    func readJSON(fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
              } catch {
                  return nil
              }
        }
        
        return nil
    }
}
