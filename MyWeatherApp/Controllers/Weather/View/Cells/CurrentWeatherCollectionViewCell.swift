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
    
    private var currentWeather: WeatherModel? {
        didSet {
            contentView.layoutIfNeeded()
        }
    }
    
    var detailsButtonAction: (()->())?
    
    // MARK: PROPERTIES
    
    private lazy var cityNamelabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "--",
            font: Fonts.cityFont,
            textColor: Colors.mainTextColor
        )
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tempLabel = getLabel(
        text: "--°",
        font: Fonts.tempLargeFont,
        color: Colors.mainTextColor
    )
    
    private lazy var weatherConditionLabel = getLabel(
        text: "--",
        font: Fonts.weatherConditionFont,
        color: Colors.mainTextColor
    )
    
    private lazy var lowAndHeightTempLabel = getLabel(
        text: "Мин. --°, макс: --°",
        font: Fonts.cityLowHeightTempFont,
        color: Colors.mainTextColor
    )
    
    private lazy var todayLabel: CustomLabel = {
        let label = CustomLabel(
            text: "--, --",
            font: Fonts.cityLowHeightTempFont,
            textColor: Colors.mainTextColor
        )
        label.textAlignment = .center
        return label
    }()
    
    private lazy var sunriseStackView = CustomStackView(
        appIcon: .sunrise)
    //        text: Date.getCurrentDate(dt: currentWeather?.sunrise ?? 0, style: .time))
    
    private lazy var cloudyStackView = CustomStackView(
        appIcon: .cloudy)
    //        text: currentWeather?.cloudinessString ?? "77%")
    
    private lazy var windStackView = CustomStackView(
        appIcon: .wind)
    //        text: currentWeather?.windSpeedString ?? "77 м/с")
    
    private lazy var humStackView = CustomStackView(
        appIcon: .hum)
    //        text: currentWeather?.humidityString ?? "77%")
    
    private lazy var sunsetStackView = CustomStackView(
        appIcon: .sunset)
    //        text: Date.getCurrentDate(dt: currentWeather?.sunset ?? 0, style: .time))
    
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(sunriseStackView)
        stack.addArrangedSubview(cloudyStackView)
        stack.addArrangedSubview(windStackView)
        stack.addArrangedSubview(humStackView)
        stack.addArrangedSubview(sunsetStackView)
        stack.axis = .horizontal
        //        stack.alignment = .leading
        stack.distribution = .equalCentering
        stack.backgroundColor = .clear
        
        return stack
    }()
    
    private lazy var separateView: SeparateLineView = {
        let line = SeparateLineView(frame: .zero)
        return line
    }()
    
    private lazy var detailsButton: CustomButton = {
        let button = CustomButton(
            normalColor: Colors.mainTextColor,
            title: "Подробный прогноз  ",
            font: Fonts.detailsButtonFont)
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 21))?.withTintColor(Colors.mainTextColor, renderingMode: .alwaysOriginal), for: .normal)
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
    
    func configureOfCell(weather: WeatherModel?, for city: CityModelEntity?) {
        guard let wthr = weather, let city = city else { return }
        
        self.cityNamelabel.text = city.name
        self.tempLabel.text = String(describing: wthr.temperatureString)
        self.weatherConditionLabel.text = String(describing: wthr.descriptionString)
        let min = String(format: "%.0f°", wthr.daily[0].temp.min)
        let max = String(format: "%.0f°", wthr.daily[0].temp.max)
        self.lowAndHeightTempLabel.text = "Мин. \(min), макс: \(max)" // add farehngate
        let currentDate = wthr.dt
        self.todayLabel.text = Date.getCurrentDate(dt: currentDate, style: .full)
        
        self.sunriseStackView.text = Date.getCurrentDate(dt: wthr.sunrise, style: .time)
        self.cloudyStackView.text = wthr.cloudinessString
        self.windStackView.text = wthr.windSpeedString
        self.humStackView.text = wthr.humidityString
        self.sunsetStackView.text = Date.getCurrentDate(dt: wthr.sunset, style: .time)
        
    }
    
    private func setupLayout() {
        
        contentView.backgroundColor = UIColor(named: "main_color")
        contentView.layer.cornerRadius = 16
        
        contentView.addSubviews(
            cityNamelabel,
            tempLabel,
            weatherConditionLabel,
            lowAndHeightTempLabel,
            todayLabel,
            detailsButton,
            separateView,
            mainStackView
        )
        
        cityNamelabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNamelabel.snp.bottom)
            make.centerX.equalToSuperview()
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
        
        mainStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(todayLabel.snp.bottom).offset(8)
        }
        
        separateView.makeConstraints(atBottom: self.snp.bottom)
        
        detailsButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.bottom).inset(25)
            make.centerX.equalToSuperview()
        }
    }
    
    
    // MARK: OBJC METHODS
    
    func detailsButtonPressed() {
        detailsButtonAction?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
}
