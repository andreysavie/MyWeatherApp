//
//  LaunchSettingsView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 02.08.2022.
//

import UIKit
import SnapKit

class LaunchSettingsView: UIView {
    
//    private lazy var titleLabel = getLabel(
//        text: "Настройки",
//        font: Fonts.settingsTitleFont,
//        color: Colors.darkTextColor
//    )
    
    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Настройки",
            font: Fonts.settingsTitleFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    private lazy var tempLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Температура",
            font: Fonts.settingsLabelFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    private lazy var windspeedLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Скорость ветра",
            font: Fonts.settingsLabelFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    private lazy var timeFormatLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Формат времени",
            font: Fonts.settingsLabelFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    private lazy var notifiesLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Уведомления",
            font: Fonts.settingsLabelFont,
            textColor: Colors.darkTextColor
        )
        return label
    }()
    
    private lazy var tempSemgentedControl = getSegmentedControl(.temp)
    private lazy var windSemgentedControl = getSegmentedControl(.speed)
    private lazy var timeSemgentedControl = getSegmentedControl(.time)
    private lazy var notifSemgentedControl = getSegmentedControl(.notifications)
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tempLabel,
            windspeedLabel,
            timeFormatLabel,
            notifiesLabel
        ])
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
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
        stackView.alignment = .trailing
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var separateView: SeparateLineView = {
        let line = SeparateLineView(frame: .zero)
        return line
    }()

    
    private lazy var setButton: CustomButton = {
        let button = CustomButton(title: "Установить", font: Fonts.settingsLabelFont)
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
        getShadow(self)
        
        addSubviews(
            titleLabel,
            labelsStackView,
            segmentedControlsStackView,
            setButton,
            separateView
        )
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
        }
        
        labelsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-70)
            make.trailing.equalTo(self.snp.centerX)
        }
        
        segmentedControlsStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalTo(self.snp.bottom).offset(-70)
            make.leading.equalTo(self.snp.centerX)
        }
        
        separateView.makeConstraints(atBottom: self.snp.bottom)

        setButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.bottom).inset(25)
            make.centerX.equalToSuperview()
        }
        
    }
}
