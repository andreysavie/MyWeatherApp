//
//  SettingsTableViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 06.08.2022.
//

import UIKit
import SnapKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    private var setting: Settings?

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Fonts.settingsLabelFont
        label.textColor = Colors.darkTextColor
        label.text = setting?.rawValue ?? "none"
        return label
    }()
    
    private lazy var dateFormatButton: UIButton = {
        let button = UIButton()
        button.setTitle("дд/мм/гггг", for: .normal)
        button.setTitleColor(Colors.mediumTextColor, for: .normal)
        button.titleLabel?.font = Fonts.settingsLabelFont
        return button
    }()
    
    private lazy var segmentedControl = getSegmentedControl(setting)
    
    func configure(_ setting: Settings) {
        self.setting = setting
        setupLayout()
        self.setNeedsDisplay()
    }
    

    
    func setupLayout() {
        
        let settingElement = segmentedControl ?? dateFormatButton
        
        contentView.addSubview(title)
        contentView.addSubview(settingElement)

        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(segmentedControl?.snp.leading ?? contentView.snp.centerX).offset(-16)
            make.centerY.equalToSuperview()
        }
        
        settingElement.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
