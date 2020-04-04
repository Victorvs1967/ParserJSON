//
//  Parser.swift
//  Parser
//
//  Created by Victor Smirnov on 04.04.2020.
//  Copyright © 2020 Victor Smirnov. All rights reserved.
//

import Foundation

struct Anser: Codable {
    var weather: [WeatherForecast]
}

struct WeatherForecast: Codable {
    var city: City
    var cod: String
    var message: Double
    var cnt: Int
    var list: [List]
}

struct City: Codable {
    var id: Int
    var name: String
    var coord: Coord
    var country: String
    var timezone: Int
}

struct Coord: Codable {
    var lon: Double
    var lat: Double
}

struct List: Codable {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: Temp
    var feels_like: FeelsLike
    var pressure: Double
    var humidity: Int
    var weather: [Weather]
    var speed: Double
    var deg: Int
    var clouds: Int
}

struct Temp: Codable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct FeelsLike: Codable {
    var day: Double
    var night: Double
    var eve: Double
    var morn: Double
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

func parse(_ filePath: String) -> [WeatherForecast]? {
    
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return nil }
    guard let forecast = try? JSONDecoder().decode(Anser.self, from: data) else { return nil }
    
    return forecast.weather
}
