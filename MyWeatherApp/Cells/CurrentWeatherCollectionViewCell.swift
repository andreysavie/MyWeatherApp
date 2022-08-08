//
//  CurrentWeatherCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 03.08.2022.
//

import UIKit
import SnapKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentWeatherCollectionViewCell"
    
    var detailsButtonAction: (()->())?
    
    // MARK: PROPERTIES
    
    private lazy var cityNameLabel = getLabel(
        text: "Москва",
        font: Fonts.cityFont,
        color: Colors.darkTextColor
    )
    
    private lazy var tempLabel = getLabel(
        text: "21°",
        font: Fonts.tempLargeFont,
        color: Colors.darkTextColor
    )
    
    private lazy var weatherConditionLabel = getLabel(
        text: "Облачно",
        font: Fonts.weatherConditionFont,
        color: Colors.darkTextColor
    )
    
    private lazy var lowAndHeightTempLabel = getLabel(
        text: "Мин. 15°, макс: 29°",
        font: Fonts.cityLowHeightTempFont,
        color: Colors.darkTextColor
    )

    private lazy var hourlyForecastView: HourlyForecastView = {
        let view = HourlyForecastView()
        return view
    }()
        
    private lazy var separateView: SeparateLineView = {
        let line = SeparateLineView(frame: .zero)
        return line
    }()
    
    private lazy var detailsButton: CustomButton = {
        let button = CustomButton(
            title: "Подробный прогноз  ",
            font: Fonts.detailsButtonFont)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 21))?.withTintColor(Colors.darkTextColor, renderingMode: .alwaysOriginal), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    
    
    // MARK: INITS
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        detailsButton.tapAction = { [weak self] in
            self?.detailsButtonPressed()
        }
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS
    
    
    func setConfigureOfCell() {
    }
    
    
    
    private func setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        getShadow(contentView)
        
        contentView.addSubviews(
            cityNameLabel,
            tempLabel,
            weatherConditionLabel,
            lowAndHeightTempLabel,
            hourlyForecastView,
            detailsButton,
            separateView
        )
        
        cityNameLabel.textAlignment = .center
        
        cityNameLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        weatherConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        lowAndHeightTempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        hourlyForecastView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lowAndHeightTempLabel.snp.bottom).offset(16)
            make.height.equalTo(130)
        }
        
        separateView.makeConstraints(atBottom: self.snp.bottom)
        
        detailsButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.bottom).inset(25)
            make.centerX.equalToSuperview()
        }
    }
    
    
    // MARK: Objc METHODS ==============================================================================
    
    func detailsButtonPressed() {
        detailsButtonAction?()
    }
    
}
