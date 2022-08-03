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

public enum Opacity {
    case full
    case half
}

public struct Fonts {
    
    // launch settings controller block
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
    static let sunTimeLabelFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    
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

public struct GradientColors {
    
    static let foneFirstColor = UIColor(red: 80/255, green: 135/255, blue: 255/255, alpha: 1)
    static let foneLastColor = UIColor(red: 42/255, green: 48/255, blue: 64/255, alpha: 1)
}

public struct Attributes {
    
    static let nabBarItemAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    static let navBarTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    
    static let settingsSemgentedControlAttributes = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
        NSAttributedString.Key.foregroundColor: UIColor.white
    ]
//    static let flightPropsLabelAttributes = [
//        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold),
//        NSAttributedString.Key.foregroundColor: UIColor.white
//    ]
//    static let airportNameLabelAttributes = [
//        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold),
//        NSAttributedString.Key.foregroundColor: UIColor.white
//    ]
//    static let cityLabelAttributes = [
//        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium),
//        NSAttributedString.Key.foregroundColor: UIColor.white
//    ]

}

public struct WeatherColor {
  static let mainTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  static let subTextColor = #colorLiteral(red: 0.5449205637, green: 0.5544300675, blue: 0.6000839472, alpha: 1)
  static let separateLineColor = #colorLiteral(red: 0.5449205637, green: 0.5544300675, blue: 0.6000839472, alpha: 1)
}

public extension UIView {
    
    func getAppIcon (_ icon: AppIcons, _ size: CGFloat, _ opacity: Opacity) -> UIImageView {
        let imageView = UIImageView()
        let name: String
        
        switch icon {
        case .sunRise:
            name = "sunrise"
        case .sunSet:
            name = "sunset"
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
        }
        
        switch opacity {
        case .full:
            imageView.layer.opacity = 1
        case .half:
            imageView.layer.opacity = 0.3
        }
        
        imageView.image = UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }
    
    func getWeatherIcon (_ icon: ForecastIcons) -> UIImageView {
        let imageView = UIImageView()
        let name: String
        
        switch icon {
        case .sun:
            name = "sun.max"
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
        
        imageView.image = UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: 28))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        return imageView
    }
    
    func getLabel (text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = font
        label.textColor = .white
        return label
    }
    
    func getSemgentedControl(_ items: [String]) -> UISegmentedControl {
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.tintColor = .clear
        control.selectedSegmentTintColor = .white.withAlphaComponent(0.5)
        control.setTitleTextAttributes(Attributes.settingsSemgentedControlAttributes, for: .normal)
        return control
    }
    
    func addSubviews(_ views: UIView ...) {
        views.forEach( { addSubview($0) } )
    }
}

public extension UIViewController {
    
    func getGradient(start: CGPoint, end: CGPoint) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            GradientColors.foneFirstColor.cgColor,
            GradientColors.foneLastColor.cgColor
        ]
        gradient.startPoint = start
        gradient.endPoint = end

        gradient.locations = [0, 1]
        return gradient
    }
}
