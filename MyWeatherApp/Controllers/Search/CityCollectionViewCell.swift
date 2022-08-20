//
//  CityCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 05.08.2022.
//

import UIKit
import SnapKit

class CityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CityCollectionViewCell"
    
    
    // MARK: PROPERTIES ============================================================================
    
    
    private lazy var cityNameLabel = getLabel(
        text: "Москва",
        font: Fonts.cityLabelFont,
        color: .white
    )
    
    private lazy var cityTimeLabel = getLabel(
        text: "12:34",
        font: Fonts.cityTimeFont,
        color: .white
    )
    
    private lazy var cityForecastLabel = getLabel(
        text: "Приимущественно облачно",
        font: Fonts.cityForecastFont,
        color: .white
    )
    
    private lazy var cityTempLabel = getLabel(
        text: "21°",
        font: Fonts.cityTempFont,
        color: .white
    )
    
    private lazy var cityLowHeightTempsLabel = getLabel(
        text: "Мин: 15°, макс: 29°",
        font: Fonts.cityLowHeightTempFont,
        color: .white
    )
    
    
    
    // MARK: INITS ============================================================================
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================
    
    
    func configureOfCell(city: CityModel) {
        self.cityNameLabel.text = city.name
    }
    
    
    
    private func setupLayout() {
        
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 16
        
        getShadow(contentView)
        
        contentView.addSubviews(
            cityNameLabel,
            cityTimeLabel,
            cityForecastLabel,
            cityTempLabel,
            cityLowHeightTempsLabel
        )
        
        cityTempLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.trailing.equalTo(cityTempLabel.snp.leading).offset(-16)
        }
        
        
        cityTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(contentView.snp.centerX)
        }
        
        cityForecastLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
            make.trailing.equalTo(cityLowHeightTempsLabel.snp.leading).offset(8)
        }
        
        cityLowHeightTempsLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16)
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
