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
    
    // MARK: PROPERTIES ============================================================================
    
    //    private var flight: Flight?
    //    private var isLiked: Bool?
    
    
    private lazy var cityNameLabel = getLabel(text: "Москва", font: Fonts.cityFont)
    private lazy var tempLabel = getLabel(text: "21°", font: Fonts.tempLargeFont)
    private lazy var weatherConditionLabel = getLabel(text: "Облачно", font: Fonts.weatherConditionFont)
    private lazy var lowAndHeightTempLabel = getLabel(text: "Мин. 15°, макс: 29°", font: Fonts.cityLowHeightTempFont)
    
    private lazy var detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробный прогноз", for: .normal)
        button.titleLabel?.font = Fonts.detailsButtonFont
        button.titleLabel?.textColor = .white
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
        
        contentView.backgroundColor = .white.withAlphaComponent(0.25)
        contentView.layer.cornerRadius = 16
        contentView.addSubviews(
            cityNameLabel,
            tempLabel,
            weatherConditionLabel,
            lowAndHeightTempLabel,
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
        
        detailsButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    
    // MARK: Objc METHODS ==============================================================================
    
    @objc
    func detailsButtonPressed() {
        detailsButtonAction?()
    }
    
}
