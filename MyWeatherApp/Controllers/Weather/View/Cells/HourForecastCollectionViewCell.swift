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
        
    let hour = Calendar.current.component(.hour, from: Date())
    
    var image: UIImage? {
        didSet {
            weatherIcon.image = image
        }
    }
    
//    private lazy var weatherIcon: UIImageView = {
//        let imageView = UIImageView()
//        return imageView
//    }()
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
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
                
        addSubview(hourlyStackView)
        
        hourlyStackView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureOfCell(_ weather: WeatherModel?, at hour: Int) {
        
        guard let wthr = weather else { return }
                
        let currentHour = Date(timeIntervalSince1970: TimeInterval(wthr.hourly[hour].dt))
        let dateformat = DateFormatter()
        dateformat.dateFormat = "HH" // "h a"
        let strHour = "\(dateformat.string(from: currentHour)):00"
        print("⏰\(strHour)")
              
        let conditionId = wthr.hourly[hour].weather[0].id
        print("🌆\(conditionId)")

        let hourlyTemp = getFormattedTemp(wthr.hourly[hour].temp)

        self.hourTitleLabel.text = strHour
        self.image = getWeatherImage(conditionId: conditionId)
        self.hourlyTempLabel.text = hourlyTemp
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
