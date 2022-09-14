//
//  DetailsForecastCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit

class DetailsForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailsForecastCollectionViewCell"
        
    // MARK: PROPERTIES
    
    private var currentWeather: WeatherModel? { didSet { self.contentView.layoutIfNeeded() } }
    
    private lazy var dayStackView = CustomStackView(
        icon: .calendar,
        size: 17,
        text: Date.getCurrentDate(dt: currentWeather?.hourly[0].dt ?? 0, style: .dayDate),
        stackAxis: .horizontal,
        color: Colors.darkTextColor
    )
    
    private lazy var timeStackView = CustomStackView(
        icon: .clock,
        size: 17,
        text: Date.getCurrentDate(dt: currentWeather?.hourly[0].dt ?? 0, style: .time),
        stackAxis: .horizontal,
        color: Colors.darkTextColor
    )
    
    private lazy var tempStackView = CustomStackView(
        icon: .temp,
        size: 17,
        text: String(format: "%.0f°", Int(currentWeather?.hourly[0].feelsLike ?? 0)),
        stackAxis: .horizontal,
        color: Colors.darkTextColor
    )
    
    private lazy var descriptionStackView = CustomStackView(
        icon: .sun,
        size: 17,
        text: currentWeather?.hourly[0].weather.description,
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var windStackView = CustomStackView(
        icon: .wind,
        size: 17,
        text: "Ветер",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var rainStackView = CustomStackView(
        icon: .drop,
        size: 17,
        text: "Осадки",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var cloudyStackView = CustomStackView(
        icon: .cloudy,
        size: 17,
        text: "Облачность",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var feelslikeValueLabel = CustomLabel(
        text: "ощущается как \(String(format: "%.0f°", Int(currentWeather?.hourly[0].feelsLike ?? 0)))",
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var windValueLabel = CustomLabel(
        text: String(format: "%.0f м/с", Int(currentWeather?.hourly[0].windSpeed ?? 0)),
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var rainValueLabel = CustomLabel(
        text: String(format: "%.0f мм", Int(((currentWeather?.hourly[0].rain?.the1H ?? 0) * 100) )),
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var cloudyValueLabel = CustomLabel(
        text: String(format: "%.0f%", currentWeather?.hourly[0].clouds ?? 0),
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var x = currentWeather?.daily[0]
    private lazy var sunriseTimeLabel: CustomLabel = {
        let label = CustomLabel(
            text: "04:39",
            font: Fonts.detailsSunTimeFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    
    private lazy var sunsetTimeLabel: CustomLabel = {
        let label = CustomLabel(
            text: "04:39",
            font: Fonts.detailsSunTimeFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            dayStackView,
            timeStackView,
            tempStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            descriptionStackView,
            windStackView,
            rainStackView,
            cloudyStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            feelslikeValueLabel,
            windValueLabel,
            rainValueLabel,
            cloudyValueLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .trailing
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: INITS
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS
    
    func configureOfCell(_ weather: WeatherModel?) {
         guard let wthr = weather else { return }
        self.currentWeather = wthr
    }
    
    
    
    private func setupLayout() {
        
        contentView.backgroundColor = Colors.subColor
        contentView.layer.cornerRadius = 16
        
        contentView.addSubviews(
            topStackView,
            leftStackView,
            rightStackView
        )
        
        topStackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
        }
        
        leftStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(36)
            make.top.equalTo(topStackView.snp.bottom).offset(8)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.top.equalTo(topStackView.snp.bottom).offset(8)
        }

    }
    
    
}


