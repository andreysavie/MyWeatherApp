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
    internal var isEUFormat: Bool? {
        didSet {
            dateFormatLabel.text = isEUFormat == true ? "дд/мм/гггг" : "мм/дд/гггг"
        }
    }

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = Fonts.settingsLabelFont
        label.textColor = Colors.darkTextColor
        label.text = setting?.rawValue ?? "none"
        return label
    }()
    
    private lazy var dateFormatLabel: CustomLabel = {

        let label = CustomLabel(
            numberOfLines: 1,
            text: "дд/мм/гггг",
            font: Fonts.settingsLabelFont,
            textColor: Colors.mediumTextColor)
        return label
    }()

    private lazy var segmentedControl = getSegmentedControl(setting)
    
    func configure(_ indexPath: IndexPath) {
        
        self.setting = indexPath.section == 0 ?
        Settings.allCases[indexPath.row] :
        Settings.allCases[indexPath.row + 3]
        
        setupLayout()
        setupSettings()
    }
        
    func setupSettings() {
        let segmentIndex = UserDefaults.standard.integer(forKey: setting!.rawValue)
        segmentedControl?.addTarget(self, action: #selector(saveSetting), for: .valueChanged)
        segmentedControl?.selectedSegmentIndex = segmentIndex
        self.isEUFormat = UserDefaults.standard.bool(forKey: setting!.rawValue)
    }
        
    func setupLayout() {
                
        let settingElement = segmentedControl ?? dateFormatLabel
        
        contentView.addSubviews(title, settingElement)

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
    
    internal func toggleSegment() {
        guard segmentedControl != nil else { return }
        segmentedControl?.selectedSegmentIndex = segmentedControl?.selectedSegmentIndex == 0 ? 1 : 0
        segmentedControl?.sendActions(for: .valueChanged)
    }
    
    @objc
    private func saveSetting() throws {
        guard let setting = setting else {
            print("UserDefaults saving error!")
            throw Errors.userDefaults
            
        }
        UserDefaults.standard.set(segmentedControl?.selectedSegmentIndex, forKey: setting.rawValue)
    }
    
}
