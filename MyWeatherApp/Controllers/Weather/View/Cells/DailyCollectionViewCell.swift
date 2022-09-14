//
//  DailyTableViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit

class DailyCollectionViewCell: UICollectionViewCell {

    static let identifier = "DailyCollectionViewCell"
    
    private var image: UIImage? { didSet { weatherIcon.image = image } }

    // MARK: PROPERTIES
    
    private lazy var arrowRight = getAppIcon(.arrow)
    
    private lazy var dayOfWeekLabel = getLabel(
        text: "--",
        font: Fonts.tenDayLabelFont,
        color: Colors.darkTextColor
    )
    
    private lazy var lowTempLabel = getLabel(
        text: "--°",
        font: Fonts.tenDayLabelFont,
        color: Colors.mainTextColor
    )
    
    private lazy var heightTempLabel = getLabel(
        text: "--°",
        font: Fonts.tenDayLabelFont,
        color: Colors.darkTextColor
    )
    
    private lazy var weatherIcon: UIImageView = {
        let view = UIImageView(frame: CGRect())
        return view
    }()
    
    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            lowTempLabel,
            heightTempLabel,
            arrowRight
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()

    // MARK: INITS

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS

    func configureOfCell(_ weather: WeatherModel?, at day: Int) {
        guard let wthr = weather else { return }

        let min = getFormattedTemp(wthr.daily[day].temp.min)
        let max = getFormattedTemp(wthr.daily[day].temp.max)
        let iconName = wthr.daily[day].weather[0].icon

        self.dayOfWeekLabel.text = day == 0 ?
        "Сегодня" :
        Date.getCurrentDate(dt: wthr.daily[day].dt, style: .day)
        
        self.image = getWeatherIcon(iconName)
        self.lowTempLabel.text = min
        self.heightTempLabel.text = max
        
    }

    
    private func setupLayout() {
        contentView.backgroundColor = Colors.subColor
        contentView.layer.cornerRadius = 16
        contentView.addSubviews(
            dayOfWeekLabel,
            weatherIcon,
            weatherStackView
        )
        
        contentView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
                
        dayOfWeekLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(contentView.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        weatherStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.leading.equalTo(weatherIcon.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
        }
    }

}
