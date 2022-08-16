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
    
    private lazy var tempLabel = getLabel(
        text: "??°",
        font: Fonts.tempLargeFont,
        color: Colors.darkTextColor
    )
    
    private lazy var weatherConditionLabel = getLabel(
        text: "unknown",
        font: Fonts.weatherConditionFont,
        color: Colors.darkTextColor
    )
    
    private lazy var lowAndHeightTempLabel = getLabel(
        text: "Мин. ??°, макс: ??°",
        font: Fonts.cityLowHeightTempFont,
        color: Colors.darkTextColor
    )
    
    private lazy var todayLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Понедельник, 8 августа",
            font: Fonts.cityLowHeightTempFont,
            textColor: Colors.darkTextColor
        )
        label.textAlignment = .center
        return label
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
    
    
    func configureOfCell(weather: WeatherModel?) {
        guard let wthr = weather else { return }
        
        self.tempLabel.text = String(describing: wthr.temperatureString)
        self.weatherConditionLabel.text = String(describing: wthr.descriptionString)
        let min = String(format: "%.0f°", wthr.daily[0].temp.min)
        let max = String(format: "%.0f°", wthr.daily[0].temp.max)
        self.lowAndHeightTempLabel.text = "Мин. \(min), макс: \(max)" // add farehngate
        self.todayLabel.text = Date.getCurrentDate()
    }
        
    private func setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        getShadow(contentView)
                
        contentView.addSubviews(
            tempLabel,
            weatherConditionLabel,
            lowAndHeightTempLabel,
            todayLabel,
            detailsButton,
            separateView
        )
        
        
        tempLabel.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
        }
        
        weatherConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        lowAndHeightTempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherConditionLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        todayLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(lowAndHeightTempLabel.snp.bottom).offset(8)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    
}
