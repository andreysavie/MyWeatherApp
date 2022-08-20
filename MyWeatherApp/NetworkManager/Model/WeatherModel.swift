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
    
    let rain: Double
    let dewPoint: Double
    
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
        case .moderateRain:
            return "Умеренный дождь"
        }
    }
    
    
    var uviString: String {
        String("\(Int(uviIndex))")
    }
    
    var uviLevel: String {
        switch Int(uviIndex) {
        case 0...2:
            return "низкий"
        case 3...5:
            return "средний"
        case 6...7:
            return "высокий"
        default:
            return "экстримальный"
        }
    }
    
    var uviDesc: String {
        switch Int(uviIndex) {
        case 0...2:
            return "Солнце сейчас не опасное"
        case 3...5:
            return "Не стоит находиться на солнце дольше 2ч."
        case 6...7:
            return "Стоит избегать нахождения на солнце"
        default:
            return "Солнце максимально опасное сейчас"
        }
    }
    
    var windDirectionString: String {
        let winddirections = ["С 􀄨", "СВ 􀰾", "В 􀄫", "ЮВ 􀱈", "Ю 􀄩", "ЮЗ 􀱃", "З 􀄪", "СЗ 􀰹"]
        let degrees = daily[0].windDeg
        let direction = Int((degrees + Int(22.5)) / 45 % 8)
        return winddirections[direction]
    }
    
    var windSpeedString: String {
        String("\(wind) м/с") // добавить империческую
    }
    
    var feelsLikeString: String {
        String(format: "%.0f°", feelsLike)
    }
    
    var feelsLikeDesc: String {
        switch Int(feelsLike) {
        case ..<Int(temperature):
            return "По ощущениям ниже из-за ветра"
        case Int(temperature)...:
            return "По ощущениям выше из-за солнца"
        default:
            return "Аналогично фактической"
        }
    }
    
    var rainString: String {
        String("\(Int(rain)) мм")
    }
    
    var rainDesc: String {
        switch Int(daily[0].rain ?? 0) {
        case ..<Int(daily[1].rain ?? 0):
            return "Завтра уровень осадков выше"
        case Int(daily[1].rain ?? 0)...:
            return "Завтра уровень осадков ниже"
        default:
            return "Завтра аналогичный уровень осадков"
        }
    }
    
    var humidityString: String {
        String("\(humidity)%")
    }
    
    var humidityDesc: String {
        "Точка росы сейчас: \(dewPointString)."
    }
    
    
    var cloudinessString: String {
        String("\(cloudiness)%")
    }
    
    var cloudinessDesc: String {
        switch description {
        case .brokenClouds:
            return "Сейчас облачно"
        case .clearSky:
            return "Сейчас ясно"
        case .fewClouds:
            return "Сейчас малооблачно"
        default:
            return "Сейчас пасмурно"
        }    }
    
    var visibilityString: String {
        String("\(visibility / 1000) км")
    }
    
    var visibilityDesc: String {
        switch description {
        case .clearSky:
            return "Сейчас ясно"
        default:
            return "Видимость ограничена"
        }
    }
    
    var pressureString: String {
        String(format: "%.0f", Double(pressure) * 0.75)
    }
    
    var temperatureString: String {
        String(format: "%.0f°", temperature)
    }
    
    var dayTempString: String {
        String(format: "%.0f°", daily[0].temp.day)
    }
    
    var nightTempString: String {
        String(format: "%.0f°", daily[0].temp.night)
    }
    
    var dewPointString: String {
        String(format: "%.0f°", dewPoint)
    }
    
}

