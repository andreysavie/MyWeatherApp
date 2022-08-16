//
//  WeatherModel.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import Foundation

// Enum for different types of collectionView cells
enum SunStateDescription {
    case sunset
    case sunrise
}

struct SunState {
    let description: SunStateDescription
    let time: Int
}

enum WindUnitType {
    case miph
    case kmph
}

enum HourlyDataType {
//    case weatherType(Hourly)
    case weatherType(Current)
    case sunState(SunState)
}

struct WeatherModel {

    let lat: Double
    let lon: Double

    let conditionId: Int
    var cityName: String
    let temperature: Double
    let timezone: Int
    let feelsLike: Double
//    let description: String
    let description: Description


    let humidity: Int
    let uviIndex: Double
    let wind: Double
    let cloudiness: Int
    let pressure: Int
    let visibility: Int

    let sunrise: Int
    let sunset: Int

    let daily: [Daily]
    let hourly: [Current]

    var hourlyDisplayData: [HourlyDataType] {
        var hourlyDataMix = [HourlyDataType]()

        // SunType cells data for sunset/sunrise for the current day and the next one
        var sunStates = [SunState(description: .sunrise, time: sunrise),
                         SunState(description: .sunset, time: sunset),
                         SunState(description: .sunrise, time: daily[1].sunrise),
                         SunState(description: .sunset, time: daily[1].sunset)]

        for i in 0...24 {
            let currentHour = hourly[i]

            // Add SunType cell data
            for (i, sunState) in sunStates.enumerated() {
                // Check the next hour syntetically
                // Add sunType cell data after current time cell and before the next time cell
                if sunState.time < currentHour.dt &&  sunState.time > Int(Date().timeIntervalSince1970) {
                    hourlyDataMix.append(HourlyDataType.sunState(SunState(description: sunState.description,
                                                                          time: sunState.time)))
                    sunStates.remove(at: i)
                }
            }
            // Add weather cell data
            let currentTemp = HourlyDataType.weatherType(currentHour)
            hourlyDataMix.append(currentTemp)
        }

        return hourlyDataMix
    }


    // Strings
    
    var descriptionString: String {
        switch description {
        case .brokenClouds:
            return "Преимущественно облачно"
        case .clearSky:
            return "Ясно"
        case .fewClouds:
            return "Малооблачно"
        case .lightRain:
            return "Легкий дождь"
        case .overcastClouds:
            return "Пасмурно"
        case .scatteredClouds:
            return "Малооблачно"
        }
    }
    
    var humidityString: String {
        String("\(humidity)%")
    }

    var windString: String {
        String("\(wind) м/с")
    }

    var cloudinessString: String {
        String("\(cloudiness)%")
    }

    var pressureString: String {
        String("\(pressure) гПа")
    }

    var visibilityString: String {
        String("\(visibility) м.")
    }

    var feelsLikeString: String {
        String(format: "Ощущается как %.0f°", feelsLike)
    }

    var temperatureString: String {
        String(format: "%.0f°", temperature)
    }

    static func getConditionNameBy(conditionId id: Int) -> String {
        switch id {
        case 200...232:
            return SystemImageName.cloudBoltFill
        case 300...321:
            return SystemImageName.cloudDrizzleFill
        case 500...531:
            return SystemImageName.cloudRainFill
        case 600...622:
            return SystemImageName.cloudSnowFill
        case 701...781:
            return SystemImageName.cloudFogFill
        case 800:
            return SystemImageName.sunMaxFill
        case 801...804:
            return SystemImageName.cloudFill
        default:
            return "error"
        }
    }
}
