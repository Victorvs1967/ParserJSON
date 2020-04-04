//
//  ParserOld.swift
//  Parser
//
//  Created by Victor Smirnov on 30.03.2020.
//  Copyright © 2020 Victor Smirnov. All rights reserved.
//

import Foundation

struct WeatherForecastOld {
    var city: CityOld
    var cod: String
    var message: Double
    var cnt: Int
    var list: [ListOld]
    
    init(dict: [String: Any]) {
        city = CityOld(dict: dict["city"] as? [String: Any] ?? [:])
        cod = dict["cod"] as? String ?? ""
        message = dict["message"] as? Double ?? 0
        cnt = dict["cnt"] as? Int ?? 0
        list = []
        for dictList in dict["list"] as? [[String: Any]] ?? [] {
            list.append(ListOld(dict: dictList))
        }
    }
}

struct CityOld {
    var id: Int
    var name: String
    var coord: CoordOld
    var country: String
    var timezone: Int
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        name = dict["name"] as? String ?? ""
        coord = CoordOld(dict: dict["coord"] as? [String: Any] ?? [:])
        country = dict["country"] as? String ?? "GB"
        timezone = dict["timezone"] as? Int ?? 0
    }
}

struct CoordOld {
    var lon: Double
    var lat: Double
    
    init(dict: [String: Any]) {
        lon = dict["lon"] as? Double ?? 0
        lat = dict["lat"] as? Double ?? 0
    }
}

struct ListOld {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: TempOld
    var feels_like: FeelsLikeOld
    var pressure: Double
    var humidity: Int
    var weather: [WeatherOld]
    var speed: Double
    var deg: Int
    var clouds: Int
    
    init(dict: [String: Any]) {
        dt = dict["dt"] as? Int ?? 0
        sunrise = dict["sunrise"] as? Int ?? 0
        sunset = dict["sunset"] as? Int ?? 0
        pressure = dict["pressure"] as? Double ?? 0
        humidity = dict["humidity"] as? Int ?? 0
        speed = dict["speed"] as? Double ?? 0
        deg = dict["deg"] as? Int ?? 0
        clouds = dict["clouds"] as? Int ?? 0
        temp = TempOld(dict: dict["temp"] as? [String: Any] ?? [:])
        feels_like = FeelsLikeOld(dict: dict["feels_like"] as? [String: Any] ?? [:])
        weather = []
        for dictWeather in dict["weather"] as? [[String: Any]] ?? [] {
            weather.append(WeatherOld(dict: dictWeather))
        }
    }
}

struct TempOld {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
    
    init(dict: [String: Any]) {
        day = dict["day"] as? Double ?? 0
        min = dict["min"] as?  Double ?? 0
        max = dict["max"] as?  Double ?? 0
        night = dict["night"] as?  Double ?? 0
        eve = dict["eve"] as?  Double ?? 0
        morn = dict["morn"] as?  Double ?? 0
    }
}

struct FeelsLikeOld {
    var day: Double
    var night: Double
    var eve: Double
    var morn: Double
    
    init(dict: [String: Any]) {
        day = dict["day"] as? Double ?? 0
        night = dict["night"] as? Double ?? 0
        eve = dict["eve"] as? Double ?? 0
        morn = dict["morn"] as? Double ?? 0
    }
}

struct WeatherOld {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int ?? 0
        main = dict["main"] as? String ?? ""
        description = dict["description"] as? String ?? ""
        icon = dict["icon"] as? String ?? ""
    }
}

func parseOld(_ filePath: String) -> [WeatherForecastOld]? {
    
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return nil }
    guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return nil }
    guard let weatherArray = dictionary["weather"] as? [[String: Any]] else { return nil }
    
    var forecast: [WeatherForecastOld] = []
    for dictWeather in weatherArray {
        forecast.append(WeatherForecastOld(dict: dictWeather))
    }
        
    return forecast
}
