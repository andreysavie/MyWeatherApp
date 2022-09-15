//
//  WeatherModel.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import Foundation

// Enum for different types of collectionView cells
//enum SunStateDescription {
//    case sunset
//    case sunrise
//}
//
//struct SunState {
//    let description: SunStateDescription
//    let time: Int
//}
//
//enum WindUnitType {
//    case miph
//    case kmph
//}
//
//enum HourlyDataType {
//    case weatherType(Current)
//    case sunState(SunState)
//}

struct WeatherModel {
    
    let lat: Double
    let lon: Double
    let dt: Int
    
    let conditionId: Int
    var cityName: String
    let temperature: Double
    let timezone: Int
    let feelsLike: Double
    let description: String
    
    let humidity: Int
    let uviIndex: Double
    
    let windSpeed: Double
    let windGust: Double
    
    let cloudiness: Int
    let pressure: Int
    let visibility: Int
    
    let sunrise: Int
    let sunset: Int
    
    let daily: [Daily]
    let hourly: [Current]
    
    let rain: Double
    let dewPoint: Double

    let icon: String
    
    
    // icons
  /*
    case 01d: .png     sun.max              case 01n: .png     moon.fill
    case 02d: .png     cloud.sun.fill       case 02n: .png     cloud.moon.fill
    case 03d: .png     cloud.fill           case 03n: .png     cloud.fill
    case 04d: .png     smoke.fill           case 04n: .png     smoke.fill
    case 09d: .png     cloud.rain.fill      case 09n: .png     cloud.rain.fill
    case 10d: .png     cloud.sun.rain.fill  case 10n: .png     cloud.moon.rain.fill
    case 11d: .png     cloud.bolt.fill      case 11n: .png     cloud.bolt.fill
    case 13d: .png     cloud.snow.fill      case 13n: .png     cloud.snow.fill
    case 50d: .png     cloud.fog.fill       case 50n: .png     cloud.fog.fill

  */
        
    
    // Strings
    
    var descriptionString: String {
        return description.prefix(1).uppercased() + description.lowercased().dropFirst()
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
    
//    var windDirectionString: String {
//        let winddirections = ["С", "СВ", "В", "ЮВ", "Ю", "ЮЗ", "З", "СЗ"]
//        let degrees = daily[0].windDeg
//        let direction = Int((degrees + Int(22.5)) / 45 % 8)
//        return winddirections[direction]
//    }
    
    var windSpeedString: String {
        String("\(Int(round(windSpeed))) м/с") // добавить империческую
    }
    
    var windGustDesc: String {
        switch windGust {
        case 0.5... :
            return String("Порывы ветра до \(Int(round(windGust))) м/с")
        default:
            return "Сегодня штиль"
        }
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
        
        // TODO: ДОПОЛНИТЬ!
        
        switch conditionId {
        case 300...531:
            return "Сейчас пасмурно"
        case 800:
            return "Сейчас ясно"
        case 801:
            return "Сейчас малооблачно"
        case 802...804:
            return "Сейчас облачно"
        default:
            return "Сейчас облачно" // или нет
        }
    }
    
    
    var visibilityString: String {
        String("\(visibility / 1000) км")
    }
    
    var visibilityDesc: String {
        switch visibility {
        case 10_000...:
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

