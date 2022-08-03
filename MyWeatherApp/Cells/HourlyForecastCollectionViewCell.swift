//
//  HourlyForecastCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 03.08.2022.
//

import UIKit
import SnapKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyForecastCollectionViewCell"
    
    private lazy var titleLabel = getLabel(text: "Облачно с 1 утра до 9 утра, в 9 утра ожидаются ливни.", font: Fonts.hourlyForecastTitleFont)
    
    private lazy var hourlyView = HourlyForecastView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        contentView.backgroundColor = .white.withAlphaComponent(0.25)
        contentView.layer.cornerRadius = 16
        contentView.addSubviews(titleLabel, hourlyView)
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
        }
        
        hourlyView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(130)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    

    
}
