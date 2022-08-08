//
//  DetailsChartCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import UIKit

class DetailsChartCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailsChartCollectionViewCell"
    
    
    // MARK: PROPERTIES ============================================================================
    
    
    private lazy var cityNameLabel = getLabel(
        text: "Москва",
        font: Fonts.detailsCityFont,
        color: Colors.darkTextColor
    )
    
    private lazy var dayForecastLabel = getLabel(
        text: "Днём 21° | Облачно",
        font: Fonts.detailsWeatherFont,
        color: Colors.darkTextColor
    )
    
    private lazy var nightForecastLabel = getLabel(
        text: "Ночью 12° | Ясно",
        font: Fonts.detailsWeatherFont,
        color: Colors.lightTextColor
    )
    
    private lazy var sunriseTimeLabel = getLabel(
        text: "04:39",
        font: Fonts.detailsSunTimeFont,
        color: Colors.darkTextColor
    )
    
    private lazy var sunsetTimeLabel = getLabel(
        text: "20:40",
        font: Fonts.detailsSunTimeFont,
        color: Colors.darkTextColor
    )
    
    private lazy var sunriseIcon = getAppIcon(.sunRise, 24)
    private lazy var sunsetIcon = getAppIcon(.sunSet, 24)
    
    
    
    // MARK: INITS ============================================================================
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================
    
    
    func setConfigureOfCell() {
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

