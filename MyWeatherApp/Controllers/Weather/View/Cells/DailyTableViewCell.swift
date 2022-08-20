//
//  DailyTableViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit

class DailyTableViewCell: UITableViewCell {

    static let identifier = "DailyTableViewCell"
    
    var image: UIImage? {
        didSet {
            weatherIcon.image = image
        }
    }

    // MARK: PROPERTIES ============================================================================

    private lazy var dayOfWeekLabel = getLabel(
        text: "Понедельник",
        font: Fonts.tenDayLabelFont,
        color: Colors.darkTextColor
    )
    
    private lazy var lowTempLabel = getLabel(
        text: "15°",
        font: Fonts.tenDayLabelFont,
        color: Colors.lightTextColor
    )
    
    private lazy var heightTempLabel = getLabel(
        text: "29°",
        font: Fonts.tenDayLabelFont,
        color: Colors.darkTextColor
    )
    
    private lazy var weatherIcon: UIImageView = {
        let view = UIImageView(frame: CGRect())
        return view
    }()
    
    private lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            weatherIcon,
            lowTempLabel,
            heightTempLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .trailing
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    

    // MARK: INITS ============================================================================

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ============================================================================

    func configureOfCell(_ weather: WeatherModel?, at day: Int) {
        guard let wthr = weather else { return }
        let conditionId = wthr.daily[day].weather[0].id

        let min = getFormattedTemp(wthr.daily[day].temp.min)
        let max = getFormattedTemp(wthr.daily[day].temp.max)

        self.dayOfWeekLabel.text = day == 0 ?
        "Сегодня" :
        Date.getCurrentDate(dt: wthr.daily[day].dt, style: .day)
        
        self.image = getWeatherImage(conditionId: conditionId)
        self.lowTempLabel.text = min
        self.heightTempLabel.text = max
        
        print("📆\(wthr.daily.count)")

        
    }

    
    private func setupLayout() {
        contentView.backgroundColor = .clear
        contentView.addSubviews(
            dayOfWeekLabel,
            weatherStackView
        )
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalToSuperview()
        }
                
        dayOfWeekLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(contentView.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        weatherStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(contentView.snp.centerX)
            make.centerY.equalToSuperview()
        }
    }

}
