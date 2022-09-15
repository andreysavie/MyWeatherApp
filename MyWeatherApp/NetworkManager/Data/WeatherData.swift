//
//  Weather.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 11.08.2022.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    var lat, lon: Double
    var timezone: String
    var timezoneOffset: Int
    var current: Current
    var hourly: [Current]
    var daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

// MARK: - Current
struct Current: Codable {
    var dt: Int
    var sunrise, sunset: Int?
    var temp, feelsLike: Double
    var pressure, humidity: Int
    var dewPoint, uvi: Double
    var clouds, visibility: Int
    var windSpeed: Double
    var windDeg: Int
    var windGust: Double
    var weather: [Weather]
    var pop: Double?
    var rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, pop, rain
    }
}

// MARK: - Rain
struct Rain: Codable {
    var the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int
    var main: String
    var weatherDescription: String
    var icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

//enum Main: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case rain = "Rain"
//}

//enum Description: String, Codable {
//    case небольшаяОблачность = "небольшая облачность"
//    case небольшойДождь = "небольшой дождь"
//    case облачноСПрояснениями = "облачно с прояснениями"
//    case пасмурно = "пасмурно"
//    case переменнаяОблачность = "переменная облачность"
//    case ясно = "ясно"
//}

// MARK: - Daily
struct Daily: Codable {
    var dt, sunrise, sunset, moonrise: Int
    var moonset: Int
    var moonPhase: Double
    var temp: Temp
    var feelsLike: FeelsLike
    var pressure, humidity: Int
    var dewPoint, windSpeed: Double
    var windDeg: Int
    var windGust: Double
    var weather: [Weather]
    var clouds: Int
    var pop, uvi: Double
    var rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    var day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    var day, min, max, night: Double
    var eve, morn: Double
}

extension Current {
    
    var windDirectionString: String {
        let winddirections = ["С", "СВ", "В", "ЮВ", "Ю", "ЮЗ", "З", "СЗ"]
        let degrees = windDeg
        let direction = Int((degrees + Int(22.5)) / 45 % 8)
        return winddirections[direction]
    }
}

extension Daily {
    
    var windDirectionString: String {
        let winddirections = ["С", "СВ", "В", "ЮВ", "Ю", "ЮЗ", "З", "СЗ"]
        let degrees = windDeg
        let direction = Int((degrees + Int(22.5)) / 45 % 8)
        return winddirections[direction]
    }
    
    var uviLevel: String {
        switch Int(uvi) {
        case 0...2:
            return "\(Int(uvi)), низкий"
        case 3...5:
            return "\(Int(uvi)), средний"
        case 6...7:
            return "\(Int(uvi)), высокий"
        default:
            return "\(Int(uvi)), экстримальный"
        }
    }
}
