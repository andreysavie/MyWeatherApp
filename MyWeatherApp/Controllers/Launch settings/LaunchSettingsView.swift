//
//  LaunchSettingsView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 02.08.2022.
//

import UIKit
import SnapKit

class LaunchSettingsView: UIView {
    
    private lazy var titleLabel = getLabel(
        text: "Настройки",
        font: Fonts.settingsTitleFont,
        color: Colors.darkTextColor
    )
    
    private lazy var settingsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.isScrollEnabled = false
        return table
    }()
    
    private lazy var separateView: SeparateLineView = {
        let line = SeparateLineView(frame: .zero)
        return line
    }()

    public lazy var setButton: CustomButton = {
        let button = CustomButton(title: "Установить", font: Fonts.settingsLabelFont)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        settingsTableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout() {
        
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        getShadow(self)
        
        
        self.addSubviews(
            titleLabel,
            settingsTableView,
            separateView,
            setButton
        )
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
        }

        
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(separateView.snp.top).offset(-16)
        }
                
        separateView.makeConstraints(atBottom: self.snp.bottom)
        
        setButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.bottom).inset(25)
            make.centerX.equalToSuperview()
        }
        
    }
    
}

extension LaunchSettingsView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(Settings.allCases.count)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configure(indexPath.section, for: indexPath.row)
        return cell

    }
    
}
