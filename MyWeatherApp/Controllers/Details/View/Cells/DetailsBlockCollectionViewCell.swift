//
//  DetailsBlockCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit

class DetailsBlockCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailsBlockCollectionViewCell"
    
    
    // MARK: PROPERTIES ============================================================================
    
    
    private lazy var titleLabel = getLabel(
        text: "􀆭 УФ ИНДЕКC",
        font: Fonts.detailsBlockTitleFont,
        color: Colors.mediumTextColor
    )
    
    private lazy var detalisValueLabel = getLabel(
        text: "14%",
        font: Fonts.detailsDataFont,
        color: Colors.darkTextColor
    )
    
    private lazy var detalisSubscriptionLabel = getLabel(
        text: "Низкий",
        font: Fonts.detailsUnderTextFont,
        color: Colors.darkTextColor
    )
    
    private lazy var detalisDescriptionLabel = getLabel(
        text: "Низкий уровень до конца дня.",
        font: Fonts.detailsDescriptionFont,
        color: Colors.lightTextColor
    )
    
    
    // MARK: INITS ============================================================================
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================
    
    
    func setConfigureOfCell() {
    }
    
    
    
    private func setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        getShadow(contentView)
        
        contentView.addSubviews(
            titleLabel,
            detalisValueLabel,
            detalisSubscriptionLabel,
            detalisDescriptionLabel
        )
        
        [titleLabel, detalisValueLabel, detalisSubscriptionLabel, detalisDescriptionLabel].forEach {
            $0.textAlignment = .left
        }

        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(16)
        }
        
        detalisValueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        detalisSubscriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detalisValueLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        detalisDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detalisSubscriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        
        
    }
    
    
}
