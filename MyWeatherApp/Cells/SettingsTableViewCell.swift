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
    
    private let setting: Settings

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Fonts.settingsLabelFont
        label.textColor = Colors.darkTextColor
        return label
    }()
    
    private lazy var segmentedControl = getSemgentedControl(setting)
    
    init(setting: Settings) {
        self.setting = setting
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        contentView.addSubviews(title, segmentedControl)
        
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(segmentedControl.snp.leading).offset(-16)
            make.centerY.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.centerY.equalToSuperview()
        }
        
        
    }

}
