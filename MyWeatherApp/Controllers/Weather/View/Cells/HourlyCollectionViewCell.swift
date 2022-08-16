//
//  HourlyForecastView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 03.08.2022.
//

import UIKit
import SnapKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyCollectionViewCell"
    
//    let currentWeather: WeatherModel?

    private lazy var hourlyForecastView: HourlyForecastView = {
        let view = HourlyForecastView()
        return view
    }()
    
//    override init (frame: CGRect) {
//        super.init(frame: .zero)
//
//        setupLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func configureOfCell(weather: WeatherModel?) {
        
        guard let wthr = weather else { return }
        
        self.hourlyForecastView = HourlyForecastView(weather: wthr)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        getShadow(contentView)
        
        contentView.addSubview(hourlyForecastView)
        
        hourlyForecastView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
//
//    private func setupLayout() {
//
//        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 16
//        getShadow(contentView)
//
//        contentView.addSubview(hourlyForecastView)
//
//        hourlyForecastView.snp.makeConstraints { make in
//            make.leading.top.trailing.bottom.equalToSuperview()
//        }
//    }
    
}
