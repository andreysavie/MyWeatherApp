//
//  Constants.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 02.08.2022.
//

import Foundation
import UIKit

public enum AppIcons {
    case sunRise
    case sunSet
    case sun
    case wind
    case temp
    case drop
    case air
    case calendar
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

public enum Settings: String {
    case notifications = "Уведомления"
    case time = "Формат времени"
    case date = "Формат даты"
    case temp = "Температура"
    case speed = "Скорость ветра"
    case visibility = "Блок видимости"
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
    static let detailsDescriptionFont = UIFont.systemFont(ofSize: 18, weight: .regular)
    
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
        case .sunRise:
            name = "sunrise"
            color = Colors.yellowColor
        case .sunSet:
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
        case .air:
            name = "humidity"
        case .calendar:
            name = "calendar"

        }
                
        imageView.image = UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(color, renderingMode: .alwaysOriginal)
        return imageView
    }
    
    func getWeatherIcon (_ icon: ForecastIcons) -> UIImageView {
        let imageView = UIImageView()
        let name: String
        var color: UIColor = Colors.blueColor
        
        switch icon {
        case .sun:
            name = "sun.max"
            color = Colors.yellowColor
        case .cloud:
            name = "cloud.fill"
        case .partlyCloud:
            name = "cloud.sun.fill"
        case .rain:
            name = "cloud.rain.fill"
        case .heavyRain:
            name = "cloud.heavyrain.fill"
        case .fog:
            name = "cloud.fog.fill"
        case .snow:
            name = "snowflake"
        case .bolt:
            name = "cloud.bolt.fill"
        case .rainBolt:
            name = "cloud.bolt.rain.fill"
        case .wind:
            name = "wind"
        }
        
        imageView.image = UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))?.withTintColor(color, renderingMode: .alwaysOriginal)
        return imageView
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

//public extension UIViewController {
//    
//    func getGradient(start: CGPoint, end: CGPoint) -> CAGradientLayer {
//        let gradient = CAGradientLayer()
//        gradient.type = .axial
//        gradient.colors = [
//            GradientColors.foneFirstColor.cgColor,
//            GradientColors.foneLastColor.cgColor
//        ]
//        gradient.startPoint = start
//        gradient.endPoint = end
//
//        gradient.locations = [0, 1]
//        return gradient
//    }
//}

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
