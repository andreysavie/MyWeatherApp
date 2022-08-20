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
    
    private lazy var blockIcon: UIImageView = {
        let view = UIImageView(frame: CGRect())
        view.tintColor = Colors.mediumTextColor
        return view
    }()

    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(
            font: Fonts.detailsBlockTitleFont,
            textColor: Colors.mediumTextColor)
        return label
    }()
    
    private lazy var detalisValueLabel: CustomLabel = {
        let label = CustomLabel(
            font: Fonts.detailsDataFont,
            textColor: Colors.darkTextColor)
        return label
    }()

    private lazy var detalisSubscriptionLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 3,
            font: Fonts.detailsUnderTextFont,
            textColor: Colors.darkTextColor)
        return label
    }()

    private lazy var detalisDescriptionLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 3,
            font: Fonts.detailsDescriptionFont,
            textColor: Colors.darkTextColor)
        return label
    }()
    
    // MARK: INITS ============================================================================
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS ===================================================================================
    
    func configureOfCell(_ weather: WeatherModel?, for item: Int) {
        guard let weather = weather else { return }
        
        self.blockIcon.image = UIImage(systemName: AppIcons.allCases[item].rawValue) ?? UIImage()
        self.titleLabel.text = BlockTitle.allCases[item].rawValue.uppercased()
        
        // TODO: - Добавить проверку на выход за пределы массива
        
        let values = [
            weather.uviString,
            weather.windDirectionString,
            weather.feelsLikeString,
            weather.rainString,
            weather.humidityString,
            weather.cloudinessString,
            weather.visibilityString,
            weather.pressureString
        ]
        
        let subscripts = [
            weather.uviLevel,
            weather.windSpeedString,
            "",
            "за последние сутки",
            "",
            "",
            "",
            "мм.рт.ст."
        ]
        
        let descripts = [
            weather.uviDesc,
            "",
            weather.feelsLikeDesc,
            weather.rainDesc,
            weather.humidityDesc,
            weather.cloudinessDesc,
            weather.visibilityDesc,
            ""
        ]
        
        self.detalisValueLabel.text = values[item]
        self.detalisSubscriptionLabel.text = subscripts[item]
        self.detalisDescriptionLabel.text = descripts[item]
    }
    
    private func setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        getShadow(contentView)
        
        contentView.addSubviews(
            blockIcon,
            titleLabel,
            detalisValueLabel,
            detalisSubscriptionLabel,
            detalisDescriptionLabel
        )
        
        [titleLabel, detalisValueLabel, detalisSubscriptionLabel, detalisDescriptionLabel].forEach {
            $0.textAlignment = .left
        }

        blockIcon.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)

        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(blockIcon.snp.trailing).offset(4)
            make.top.trailing.equalToSuperview().inset(16)
        }
        
        detalisValueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        detalisSubscriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detalisValueLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        detalisDescriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        
        
    }
    
    
}
