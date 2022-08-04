//
//  CurrentWeatherCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 03.08.2022.
//

import UIKit
import SnapKit

extension UIView {
    func setShadow(_ view: UIView) {
        view.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        view.layer.shadowRadius = 10.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
    }
}

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CurrentWeatherCollectionViewCell"
    
    var detailsButtonAction: (()->())?
    
    // MARK: PROPERTIES ============================================================================
    
    //    private var flight: Flight?
    //    private var isLiked: Bool?
    
    
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
    
    private lazy var detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробный прогноз 􀆊", for: .normal)
        button.titleLabel?.font = Fonts.detailsButtonFont
        button.setTitleColor(Colors.darkTextColor, for: .normal)
        button.backgroundColor = .clear // ??
        button.layer.cornerRadius = 16 // ??
        button.addTarget(self, action: #selector(detailsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    
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
        
        setShadow(contentView)
        
        contentView.addSubviews(
            cityNameLabel,
            tempLabel,
            weatherConditionLabel,
            lowAndHeightTempLabel,
            hourlyForecastView,
            detailsButton
        )
        
        cityNameLabel.textAlignment = .center // move to facade!
        
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
//            make.centerX.equalToSuperview()
            make.height.equalTo(130)
        }
        
        detailsButton.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
//            make.top.equalTo(hourlyForecastView.snp.bottom).offset(16)
        }
                
    }
    
    
    // MARK: Objc METHODS ==============================================================================
    
    @objc
    func detailsButtonPressed() {
        detailsButtonAction?()
    }
    
}
