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
    
    
    // MARK: PROPERTIES ============================================================================
    
    
    private lazy var cityNameLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Москва",
            font: Fonts.detailsCityFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    private lazy var dayForecastLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "Днём 21° | Облачно",
            font: Fonts.detailsWeatherFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    private lazy var nightForecastLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "Днём 21° | Облачно",
            font: Fonts.detailsWeatherFont,
            textColor: Colors.lightTextColor
        )
        return label
    }()
    
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
    
    private lazy var sunriseIcon = getAppIcon(.sunrise, 24)
    private lazy var sunsetIcon = getAppIcon(.sunset, 24)
    
    
    
    // MARK: INITS ============================================================================
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================
    
    
    func configureOfCell(_ weather: WeatherModel?, for city: CityModel?) {
        guard let city = city, let wthr = weather else { return }
        
        self.cityNameLabel.text = city.name
        
        let dayTemp = String(describing: wthr.dayTempString)
        let nightTemp = String(describing: wthr.nightTempString)

        self.dayForecastLabel.text = "Днём \(dayTemp) | \(wthr.descriptionString)" // изменить на дневное!
        self.nightForecastLabel.text = "Ночью \(nightTemp) | \(wthr.descriptionString)" // изменить на ночное!

        self.sunriseTimeLabel.text = Date.getCurrentDate(dt: wthr.sunrise, style: .time)
        self.sunsetTimeLabel.text = Date.getCurrentDate(dt: wthr.sunset, style: .time)
    }
    
    
    
    private func setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        getShadow(contentView)
        
        contentView.addSubviews(
            cityNameLabel,
            dayForecastLabel,
            nightForecastLabel,
            sunriseTimeLabel,
            sunsetTimeLabel,
            sunriseIcon,
            sunsetIcon
        )
        
        cityNameLabel.textAlignment = .left
        
        cityNameLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
        }
        
        dayForecastLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        nightForecastLabel.snp.makeConstraints { make in
            make.top.equalTo(dayForecastLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        sunriseIcon.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
        }
        
        sunsetIcon.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16)
        }
        
        sunriseTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(sunriseIcon.snp.trailing)
            make.centerY.equalTo(sunriseIcon)
        }
        
        sunsetTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(sunsetIcon.snp.leading)
            make.centerY.equalTo(sunsetIcon)
        }
        
        
    }
    
    
}


