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
    
    private lazy var dayStackView = CustomStackView(
        appIcon: .calendar,
        size: 17,
        stackAxis: .horizontal,
        color: Colors.darkTextColor
    )
    
    private lazy var timeStackView = CustomStackView(
        appIcon: .clock,
        size: 17,
        stackAxis: .horizontal,
        color: Colors.darkTextColor
    )
    
    private lazy var tempStackView = CustomStackView(
        appIcon: .temp,
        size: 17,
        stackAxis: .horizontal,
        color: Colors.darkTextColor
    )
    
    private lazy var descriptionStackView = CustomStackView(
        appIcon: .sun,
        size: 17,
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var windStackView = CustomStackView(
        appIcon: .wind,
        size: 17,
        text: "Ветер",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var rainStackView = CustomStackView(
        appIcon: .drop,
        size: 17,
        text: "Осадки",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var cloudyStackView = CustomStackView(
        appIcon: .cloudy,
        size: 17,
        text: "Облачность",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var feelslikeValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var windValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var rainValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var cloudyValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
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
    
    func configureOfCell(_ weather: WeatherModel?, for hour: Int) {
         guard let wthr = weather else { return }
        let desc = wthr.hourly[hour].weather[0].weatherDescription
        dayStackView.text = Date.getCurrentDate(dt: wthr.hourly[hour].dt, style: .dayDate)
        timeStackView.text = Date.getCurrentDate(dt: wthr.hourly[hour].dt, style: .time)
        tempStackView.text = String(format: "%.0f°", wthr.hourly[hour].feelsLike)
        
        descriptionStackView.text = desc.prefix(1).uppercased() + desc.lowercased().dropFirst()
        feelslikeValueLabel.text = "ощущается как \(Int(wthr.hourly[hour].feelsLike))°"
        windValueLabel.text = "\(Int(wthr.hourly[hour].windSpeed)) м/с"
        rainValueLabel.text = "\(Int(((wthr.hourly[hour].rain?.the1H ?? 0) * 100))) мм"
        cloudyValueLabel.text = "\(wthr.hourly[hour].clouds)%"

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


