//
//  Weather.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 11.08.2022.
//

import Foundation

//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.weatherTask(with: url) { weather, response, error in
//     if let weather = weather {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Current]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, hourly, daily
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.currentTask(with: url) { current, response, error in
//     if let current = current {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Current
struct Current: Codable {
    let dt: Int
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherElement]
    let pop: Double?
    let rain: Rain?

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

//
// To read values from URLs:
//
//   let task = URLSession.shared.rainTask(with: url) { rain, response, error in
//     if let rain = rain {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.weatherElementTask(with: url) { weatherElement, response, error in
//     if let weatherElement = weatherElement {
//       ...
//     }
//   }
//   task.resume()

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main: Main
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.dailyTask(with: url) { daily, response, error in
//     if let daily = daily {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherElement]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double

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
        case weather, clouds, pop, rain, uvi
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.feelsLikeTask(with: url) { feelsLike, response, error in
//     if let feelsLike = feelsLike {
//       ...
//     }
//   }
//   task.resume()

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.tempTask(with: url) { temp, response, error in
//     if let temp = temp {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func weatherTask(with url: URL, completionHandler: @escaping (Weather?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
