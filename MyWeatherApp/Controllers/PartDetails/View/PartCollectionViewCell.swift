//
//  PartCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 15.09.2022.
//

import Foundation
import UIKit
import SnapKit

class PartCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PartCollectionViewCell"
        
    // MARK: PROPERTIES
    
    private lazy var feelsLikeStackView = CustomStackView(
        appIcon: .sun,
        text: "По ощущениям",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var windStackView = CustomStackView(
        appIcon: .wind,
        text: "Ветер",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var uviStackView = CustomStackView(
        appIcon: .sun,
        text: "Уф. индекс",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var rainStackView = CustomStackView(
        appIcon: .drop,
        text: "Осадки",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var cloudyStackView = CustomStackView(
        appIcon: .cloudy,
        text: "Облачность",
        stackAxis: .horizontal,
        color: Colors.mainColor
    )
    
    private lazy var feelslikeValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var windValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var uviValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var rainValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    
    private lazy var cloudyValueLabel = CustomLabel(
        font: Fonts.detailsSunTimeFont,
        textColor: Colors.lightTextColor
    )
    

    private lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            feelsLikeStackView,
            windStackView,
            uviStackView,
            rainStackView,
            cloudyStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 28
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            feelslikeValueLabel,
            windValueLabel,
            uviValueLabel,
            rainValueLabel,
            cloudyValueLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 28
        stackView.alignment = .trailing
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
    
    func configureOfCell(_ weather: WeatherModel?, of day: Int, for time: TimeOfDay) {
        guard let weather = weather else { return }
        
        let wthr = weather.daily[day]
        
        let temp = time == .day ? wthr.temp.day : wthr.temp.night
        let feelsLike = time == .day ? wthr.feelsLike.day : wthr.feelsLike.night
        
        feelslikeValueLabel.text = "\(Int(feelsLike))°"
        windValueLabel.text = "\(Int(wthr.windSpeed)) м/с, \(wthr.windDirectionString)"
        uviValueLabel.text = wthr.uviLevel
        rainValueLabel.text = "\(Int(((wthr.rain ?? 0) * 100))) мм"
        cloudyValueLabel.text = "\(wthr.clouds)%"

    }
    
    
    
    private func setupLayout() {
        
        contentView.backgroundColor = Colors.subColor
        contentView.layer.cornerRadius = 16
        
        contentView.addSubviews(
            leftStackView,
            rightStackView
        )
        
        
        leftStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(16)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(16)
        }

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
