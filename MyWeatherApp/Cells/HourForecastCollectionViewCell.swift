//
//  HourForecastCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 03.08.2022.
//

import UIKit
import SnapKit

class HourForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourForecastCollectionViewCell"
    
    private lazy var hourTitleLabel = getLabel(text: "12pm", font: Fonts.hourlyTimeFont)
    private lazy var weatherIcon = getWeatherIcon(.heavyRain)
    private lazy var hourlyTempLabel = getLabel(text: "21°", font: Fonts.hourlyTempFont)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        addSubviews(hourTitleLabel, weatherIcon, hourlyTempLabel)
        
        hourTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        hourlyTempLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }

    }
    
    func configure() {
    }
    
}
