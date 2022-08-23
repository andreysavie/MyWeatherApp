//
//  Constants.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 02.08.2022.
//

import Foundation
import UIKit

struct CoreData {
    static let modelName = "CitiesModel"
    struct City {
        static let entityName = "City"
        static let name = "name"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let orderPosition = "orderPosition"
    }
}

struct CellIdentifier {
    static let cityCell = "cityCell"
    static let cityLoadingCell = "cityLoadingCell"
    static let dailyForecastCell = "dailyForecastCell"
    static let hourlyForecastCell = "hourlyForecastCell"
    static let colorThemeCell = "colorThemeCell"
    static let appIconCell = "AppIconCell"
}

struct ImageName {
    static let deleteImage = "DeleteAction"
    
    static let appIcon = "AppIcon"
    static let darkWhiteCloudAppIcon3x = "darkWhiteCloudAppIcon@3x.png"
    static let whiteSunAppIcon3x = "whiteSunAppIcon@3x.png"
    static let cornerSun3x = "cornerSun@3x.png"
    static let orangeCloud3x = "orangeCloud@3x.png"
    static let moon3x = "moon@3x.png"
    static let yellowSun3x = "yellowSun@3x.png"
    static let blueWhiteCloud3x = "blueWhiteCloud@3x.png"
}

struct SystemImageName {
    static let sunMaxFill = "sun.max.fill"
    static let sunriseFill = "sunrise.fill"
    static let sunsetFill = "sunset.fill"
    static let eyeFill = "eye.fill"
    static let arrowDownLine = "arrow.down.to.line"
    static let wind = "wind"
    static let cloudFill = "cloud.fill"
    static let drop = "drop.fill"
    static let cloudFogFill = "cloud.fog.fill"
    static let cloudSnowFill = "cloud.snow.fill"
    static let cloudRainFill = "cloud.rain.fill"
    static let cloudDrizzleFill = "cloud.drizzle.fill"
    static let cloudBoltFill = "cloud.bolt.fill"
    static let switch2 = "switch.2"
    static let magnifyingglass = "magnifyingglass"
    static let checkmark = "checkmark"
    static let envelope = "envelope"
    static let paperplane = "paperplane"
    static let paintbrush = "paintbrush"
    static let ruler = "ruler"
    
    static let arrowDown = "chevron.compact.down"
    static let arrowUp = "chevron.compact.up"
}

struct AccessabilityIdentifier {
    static let mainMenuTableViewCell = "MainMenuTableViewCell"
    
    static let settingsButton = "SettingsButton"
    static let searchButton = "SearchButton"
    
    static let addCityCell = "AddCityCell"
    
    static let colorSettingsTableView = "ColorSettingsTableView"
    
    static let settingsUnitSwitch = "SettingsUnitSwitch"
    
    static let settingsTableView = "SettingsTableView"
}

struct UDManager {
    static let unit = "Unit"
    static let imperial = "imperial"
    static let metric = "metric"
    
    static let currentColorTheme = "currentColorTheme"
    static let colorThemePositionNumber = "colorThemePositionNumber"
    
    static let appIconNumber = "AppIconNumber"
}

struct Network {
    static let baseURL = "https://api.openweathermap.org/data/2.5/onecall?"
    static let geocodeURL = "https://geocode-maps.yandex.ru/1.x/?"
    static let apiKey = "179a1ef614ca272c4033f5abe4743aed"
    static let geocodingApiKey = "44ec1ff1-8646-4217-bc84-72cacc2c4217"
    static let lat = "lat="
    static let lon = "lon="
    static let appid = "appid="
    static let units = "units="
    static let exclude = "exclude="
    static let minutely = "minutely"
}

struct Links {
    static let telegramAppLink = "https://t.me/climaWeather"
    static let telegramAppstoreLink = "itms-apps://itunes.apple.com/app/id686449807"
}

struct Misc {
    static let defaultSityName = "-"
    static let colorThemeLocalFile = "ColorThemes"
}

public enum DataStyle {
    case hour // time like "21"
    case time // time like "21:00"
    case day // just day of week
    case full // day of week, number and month
}


public enum AppIcons: String, CaseIterable {
    case sun = "sun.max"
    case wind = "wind"
    case temp = "thermometer"
    case drop = "drop.fill"
    case hum = "humidity"
    case cloudy = "cloud.fill"
    case visibility = "binoculars.fill"
    case pressure = "barometer"
    case sunrise = "sunrise.fill"
    case sunset = "sunset.fill"
    case calendar = "calendar"
}

public enum ForecastIcons {
    case sun
    case cloud
    case partlyCloud
    case rain
    case heavyRain
    case fog
    case snow
    case bolt
    case rainBolt
    case wind
}

public enum Settings: String, CaseIterable {
    case notifications = "Уведомления"
    case time = "Формат времени"
    case date = "Формат даты"
    case temp = "Температура"
    case speed = "Скорость ветра"
    case visibility = "Блок видимости"
}

public enum BlockTitle: String, CaseIterable {
    case uvi = "УФ индекс"
    case wind = "Ветер"
    case feels = "Ощущается"
    case prec = "Осадки"
    case hum = "Влажность"
    case cloud = "Облачность"
    case vis = "Видимость"
    case press = "Давление"
}


public enum BlockType {
    case icon
    case label
}

public struct Colors {
    static let darkTextColor = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1)
    static let mediumTextColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
    static var lightTextColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
    
    static let blueColor = UIColor(red: 90/255, green: 196/255, blue: 255/255, alpha: 1)
    static let yellowColor = UIColor(red: 248/255, green: 215/255, blue: 74/255, alpha: 1)
    
    static let segmentedControlBackColor = UIColor(red: 90/255, green: 196/255, blue: 255/255, alpha: 1)
    static let settingsBackgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    static let separateLineColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
    static let navigationBarColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
    
    
}



public struct Fonts {
    
    // onboarding view
    static let onboardTitleFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    static let onboardDescriptionFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let onboardConfimFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
    static let onboardDeclineFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    
    
    // launch settings controller view
    static let settingsLabelFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    static let settingsTitleFont = UIFont.systemFont(ofSize: 37, weight: .regular)
    
    // weather controller: current forecast
    static let cityFont = UIFont.systemFont(ofSize: 37, weight: .regular)
    static let tempLargeFont = UIFont.systemFont(ofSize: 102, weight: .thin)
    static let weatherConditionFont = UIFont.systemFont(ofSize: 24, weight: .regular)
    static let tempUnderFont = UIFont.systemFont(ofSize: 17, weight: .light)
    static let detailsButtonFont = UIFont.systemFont(ofSize: 21, weight: .regular)
    
    // weather controller: hourly forecast
    static let hourlyForecastTitleFont = UIFont.systemFont(ofSize: 18, weight: .regular)
    static let hourlyTimeFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    static let hourlyTempFont = UIFont.systemFont(ofSize: 22, weight: .medium)
    
    // weather controller: 10-day forecast
    static let tenDayTitleFont = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let tenDayLabelFont = UIFont.systemFont(ofSize: 22, weight: .medium)
    
    // details controller: city block
    static let detailsCityFont = UIFont.systemFont(ofSize: 37, weight: .regular)
    static let detailsWeatherFont = UIFont.systemFont(ofSize: 24, weight: .regular)
    static let detailsSunTimeFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    
    
    // details controller: details block
    static let detailsBlockTitleFont = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let detailsDataFont = UIFont.systemFont(ofSize: 36, weight: .regular)
    static let detailsUnderTextFont = UIFont.systemFont(ofSize: 22, weight: .medium)
    static let detailsUnderTextFontSmall = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let detailsDescriptionFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    // choose city controller
    static let cityChooseLabel = UIFont.systemFont(ofSize: 37, weight: .bold)
    static let cityTFPlaceholderFont = UIFont.systemFont(ofSize: 19, weight: .regular)
    static let cityLabelFont = UIFont.systemFont(ofSize: 25, weight: .bold)
    static let cityTimeFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let cityForecastFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let cityTempFont = UIFont.systemFont(ofSize: 53, weight: .light)
    static let cityLowHeightTempFont = UIFont.systemFont(ofSize: 17, weight: .light)
    
}

public struct Labels {
    
}


public struct Attributes {
    
    static let nabBarItemAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    static let navBarTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    
    static let settingsSemgentedControlAttributes = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
        NSAttributedString.Key.foregroundColor: Colors.darkTextColor
    ]
    
}

public struct WeatherColor {
}

public extension UIView {
    
    func getShadow (_ view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        view.layer.shadowRadius = 10.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
    }
    
    func getAppIcon (_ icon: AppIcons, _ size: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        let name: String
        var color = Colors.mediumTextColor
        
        switch icon {
        case .sunrise:
            name = "sunrise"
            color = Colors.yellowColor
        case .sunset:
            name = "sunset"
            color = Colors.yellowColor
        case .sun:
            name = "sun.max"
        case .wind:
            name = "wind"
        case .temp:
            name = "thermometer"
        case .drop:
            name = "drop.fill"
        case .calendar:
            name = "calendar"
        case .pressure:
            name = "barometer"
        case .visibility:
            name = "binoculars.fill"
        case .cloudy:
            name = "cloud.fill"
        case .hum:
            name = "humidity"

        }
        
        imageView.image = UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(color, renderingMode: .alwaysOriginal)
        return imageView
    }
    
    func getWeatherIcon (conditionId id: Int) -> UIImageView {
        let imageView = UIImageView()
        let name = getConditionNameBy(conditionId: id)
        var color = name == SystemImageName.sunMaxFill ?
                            Colors.yellowColor :
                            Colors.blueColor
        
//        switch id {
//        case 200...232:
//            name = SystemImageName.cloudBoltFill
//        case 300...321:
//            name = SystemImageName.cloudDrizzleFill
//        case 500...531:
//            name = SystemImageName.cloudRainFill
//        case 600...622:
//            name = SystemImageName.cloudSnowFill
//        case 701...781:
//            name = SystemImageName.cloudFogFill
//        case 800:
//            name = SystemImageName.sunMaxFill
//            color = Colors.yellowColor
//        case 801...804:
//            name = SystemImageName.cloudFill
//        default:
//            return UIImageView()
//        }
        
        imageView.image = UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))?.withTintColor(color, renderingMode: .alwaysOriginal)
        return imageView
    }
    
    func getWeatherImage (conditionId id: Int) -> UIImage {
        let name = getConditionNameBy(conditionId: id)
        let color = name == SystemImageName.sunMaxFill ?
                            Colors.yellowColor :
                            Colors.blueColor
                
        return UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))?.withTintColor(color, renderingMode: .alwaysOriginal) ?? UIImage()
    }
    
    func getConditionNameBy(conditionId id: Int) -> String {
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
    
    
    
    func getLabel (text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
    func getSegmentedControl(_ setting: Settings?) -> UISegmentedControl? {
        
        var items: [String]
        
        switch setting {
        case .notifications:
            items = ["On", "Off"]
        case .time:
            items = ["12", "24"]
        case .date:
            return nil
        case .temp:
            items = ["C", "F"]
        case .speed:
            items = ["Mi", "Km"]
        case .visibility:
            items = ["Mi", "Km"]
        case .none:
            return nil
        }
        
        
        let control = UISegmentedControl(items: items)
        control.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        control.selectedSegmentIndex = 0
        control.backgroundColor = Colors.segmentedControlBackColor
        control.selectedSegmentTintColor = .white
        control.setTitleTextAttributes(Attributes.settingsSemgentedControlAttributes, for: .normal)
        return control
    }
    
    func addSubviews(_ views: UIView ...) {
        views.forEach( { addSubview($0) } )
    }
}

public extension UIView {
    
    func getFormattedTemp (_ temp: Double) -> String {
        String(format: "%.0f°", temp)
    }
    
//    func getBlockTitle(for item: Int) -> String {
//        guard item >= 0 , item <= 8 else { return "block label error" }
//
////        let array = type == .icon ?
////        ["sun.max", "wind", "thermometer", "drop.fill", "humidity", "humidity", "cloud.fill", "binoculars.fill", "barometer"]:
//        let array = ["УФ индекс", "Ветер", "Ощущается", "Осадки", "Влажность", "Облачность", "Видимость", "Давление"]
//
//        return array[item]
//    }
    
    
//    func switchItem (_ item: Int) {}
}
public extension Date {
    
    static func getCurrentDate(dt: Int = 0, style: DataStyle = .full) -> String {
        print("🐰\(dt)")
        let dateFormatter = DateFormatter()
        
        let date = dt == 0 ? Date() : Date(timeIntervalSince1970: TimeInterval(dt))
        switch style {
        case .hour:
            dateFormatter.dateFormat = "HH"
        case .time:
            dateFormatter.dateFormat = "HH:mm"
        case .day:
            dateFormatter.dateFormat = "EE, d"
        case .full:
            dateFormatter.dateFormat = "EEEE, MMMM d, HH:mm"
        }
        
        let str = dateFormatter.string(from: date)
        return style == .full || style == .day ? str : str.prefix(1).uppercased() + str.lowercased().dropFirst()
    }
}
