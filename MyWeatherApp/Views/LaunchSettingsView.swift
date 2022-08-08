//
//  LaunchSettingsView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 02.08.2022.
//

import UIKit
import SnapKit

class LaunchSettingsView: UIView {
    
    private let temps = ["C", "F"]
    private let speeds = ["Mi", "Km"]
    private let timeFormats = ["12", "24"]
    private let onOff = ["Вкл", "Выкл"]

    private lazy var title = getLabel(
        text: "Настройки",
        font: Fonts.settingsTitleFont,
        color: Colors.darkTextColor
    )
    
    private lazy var tempLabel = getLabel(
        text: "Температура",
        font: Fonts.settingsLabelFont,
        color: Colors.darkTextColor
    )
    
    private lazy var windspeedLabel = getLabel(
        text: "Скорость ветра",
        font: Fonts.settingsLabelFont,
        color: Colors.darkTextColor
    )
    
    private lazy var timeFormatLabel = getLabel(
        text: "Формат времени",
        font: Fonts.settingsLabelFont,
        color: Colors.darkTextColor
    )
    
    private lazy var NotifiesLabel = getLabel(
        text: "Уведомления",
        font: Fonts.settingsLabelFont,
        color: Colors.darkTextColor
    )

    private lazy var tempSemgentedControl = getSegmentedControl(.temp)
    private lazy var windSemgentedControl = getSegmentedControl(.speed)
    private lazy var timeSemgentedControl = getSegmentedControl(.time)
    private lazy var notifSemgentedControl = getSegmentedControl(.notifications)
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tempLabel,
            windspeedLabel,
            timeFormatLabel,
            NotifiesLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var segmentedControlsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tempSemgentedControl!,
            windSemgentedControl!,
            timeSemgentedControl!,
            notifSemgentedControl!
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .trailing
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var separateView: SeparateLineView = {
        let line = SeparateLineView(frame: .zero)
        return line
    }()

    private lazy var setButton: UIButton = {
        let button = UIButton()
        button.setTitle("Установить", for: .normal)
        button.titleLabel?.font = Fonts.settingsLabelFont
        button.tintColor = Colors.darkTextColor
        return button
    }()
    
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layout() {
        
        backgroundColor = .white
        layer.cornerRadius = 16
        setShadow(self)
        
        addSubviews(title, labelsStackView, segmentedControlsStackView, setButton)
        
        
        title.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(title.snp.bottom).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-70)
            make.trailing.equalTo(self.snp.centerX)
        }
        
        segmentedControlsStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(title.snp.bottom).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-70)
            make.leading.equalTo(self.snp.centerX)
        }
        
//        separateView.makeConstraints(atBottom: self.snp.bottom)
        
        setButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
    }
}
