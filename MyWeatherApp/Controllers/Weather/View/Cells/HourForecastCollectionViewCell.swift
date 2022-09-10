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
            
    private var image: UIImage? { didSet { weatherIcon.image = image } }
    
    private lazy var weatherIcon: UIImageView = {
        let view = UIImageView(frame: CGRect())
        return view
    }()
    
    private lazy var hourTitleLabel = getLabel(
        text: "12pm",
        font: Fonts.hourlyTimeFont,
        color: Colors.darkTextColor
    )
    private lazy var hourlyTempLabel = getLabel(
        text: "21°",
        font: Fonts.hourlyTempFont,
        color: Colors.darkTextColor
    )
    
    private lazy var hourlyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            hourTitleLabel,
            weatherIcon,
            hourlyTempLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
                
        addSubview(hourlyStackView)
        
        hourlyStackView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    internal func configureOfCell(_ weather: WeatherModel?, at hour: Int) {
        
        guard let wthr = weather else { return }
                
        let strHour = Date.getCurrentDate(dt: wthr.hourly[hour].dt, style: .hour)
        let hourlyTemp = getFormattedTemp(wthr.hourly[hour].temp)
        let iconName = wthr.hourly[hour].weather[0].icon

        self.hourTitleLabel.text = strHour
        self.image = getWeatherIcon(iconName)
        self.hourlyTempLabel.text = hourlyTemp
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
