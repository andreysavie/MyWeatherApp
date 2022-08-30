////
////  CityCollectionViewCell.swift
////  MyWeatherApp
////
////  Created by Андрей Рыбалкин on 05.08.2022.
////
//
//import UIKit
//import SnapKit
//
//class CityCollectionViewCell: UICollectionViewCell {
//
//    static let identifier = "CityCollectionViewCell"
//
//
//    // MARK: PROPERTIES ============================================================================
//
//
//    private lazy var cityNameLabel = getLabel(
//        text: "Москва",
//        font: Fonts.cityLabelFont,
//        color: .white
//    )
//
//    private lazy var cityTimeLabel = getLabel(
//        text: "12:34",
//        font: Fonts.cityTimeFont,
//        color: .white
//    )
//
//    private lazy var cityForecastLabel = getLabel(
//        text: "Приимущественно облачно",
//        font: Fonts.cityForecastFont,
//        color: .white
//    )
//
//    private lazy var cityTempLabel = getLabel(
//        text: "21°",
//        font: Fonts.cityTempFont,
//        color: .white
//    )
//
//    private lazy var cityLowHeightTempsLabel = getLabel(
//        text: "Мин: 15°, макс: 29°",
//        font: Fonts.cityLowHeightTempFont,
//        color: .white
//    )
//
//
//
//    // MARK: INITS ============================================================================
//
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        setupLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: METHODS ===================================================================================
//
//
//    func configureOfCell(city: CityModelEntity) {
//        self.cityNameLabel.text = city.name
//    }
//
//
//
//    private func setupLayout() {
//
//        contentView.backgroundColor = .systemBlue
//        contentView.layer.cornerRadius = 16
//
//        getShadow(contentView)
//
//        contentView.addSubviews(
//            cityNameLabel,
//            cityTimeLabel,
//            cityForecastLabel,
//            cityTempLabel,
//            cityLowHeightTempsLabel
//        )
//
//        cityTempLabel.snp.makeConstraints { make in
//            make.top.trailing.equalToSuperview().inset(16)
//        }
//
//        cityNameLabel.snp.makeConstraints { make in
//            make.leading.top.equalToSuperview().inset(16)
//            make.trailing.equalTo(cityTempLabel.snp.leading).offset(-16)
//        }
//
//        cityTimeLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().inset(16)
//            make.top.equalTo(cityNameLabel.snp.bottom).offset(4)
//            make.trailing.equalTo(contentView.snp.centerX)
//        }
//
//        cityForecastLabel.snp.makeConstraints { make in
//            make.leading.bottom.equalToSuperview().inset(16)
//            make.trailing.equalTo(cityLowHeightTempsLabel.snp.leading).offset(8)
//        }
//
//        cityLowHeightTempsLabel.snp.makeConstraints { make in
//            make.trailing.bottom.equalToSuperview().inset(16)
//        }
//
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
//
//}

//
//  CityTableViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 05.08.2022.
//

import UIKit
import SnapKit

class CityTableViewCell: UITableViewCell {
    
    static let identifier = "CityTableViewCell"
    
    
    // MARK: PROPERTIES ============================================================================
        
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.frame = CGRect(
            x: contentView.frame.midX,
            y: contentView.frame.midY,
            width: 50,
            height: 50)
        return indicator
    }()
    
    private lazy var cityNameLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 2,
            text: "--",
            font: Fonts.cityLabelFont,
            textColor: .white)
            return label
    }()
        
    private lazy var cityTimeLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "--:--",
            font: Fonts.cityTimeFont,
            textColor: .white)
            return label
    }()
    
    private lazy var cityForecastLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "--",
            font: Fonts.cityForecastFont,
            textColor: .white)
            return label
    }()
        
    private lazy var cityTempLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "--°",
            font: Fonts.cityTempFont,
            textColor: .white)
            return label
    }()
    
    private lazy var cityLowHeightTempsLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "Мин: --°, макс: --°",
            font: Fonts.cityLowHeightTempFont,
            textColor: .white)
            return label
    }()
    
    
    
    // MARK: INITS ============================================================================
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================
    
    
    func configureOfCell(weather: WeatherModel?) {
        guard let wthr = weather else { return }
        
        indicator.stopAnimating()
        
        let currentDate = wthr.dt
        let min = String(format: "%.0f°", wthr.daily[0].temp.min)
        let max = String(format: "%.0f°", wthr.daily[0].temp.max)
        
        self.cityNameLabel.text = wthr.cityName
        self.cityTempLabel.text = wthr.temperatureString
        self.cityTimeLabel.text = Date.getCurrentDate(dt: currentDate, style: .time)
        self.cityLowHeightTempsLabel.text = "Мин. \(min), макс: \(max)"
        self.cityForecastLabel.text = wthr.descriptionString
    }
    
    func configureOfCell(city: CityModelEntity?) {
        guard let city = city else { return }
        self.cityNameLabel.text = city.name
    }
    
    
    
    private func setupLayout() {
        
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 16
        
//        getShadow(contentView)
        
        contentView.addSubviews(
            cityNameLabel,
            cityTimeLabel,
            cityForecastLabel,
            cityTempLabel,
            cityLowHeightTempsLabel,
            indicator
        )
        
        indicator.startAnimating()
        
        cityTempLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.trailing.equalTo(contentView.snp.centerX)
        }
        
        cityTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(contentView.snp.centerX)
        }
        
        cityForecastLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
            make.trailing.equalTo(contentView.snp.centerX)
        }
        
        cityLowHeightTempsLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16)
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
}
