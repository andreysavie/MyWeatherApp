//
//  CustomStackView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 30.08.2022.
//

import Foundation
import UIKit
import SnapKit

class CustomStackView: UIStackView {
    
    var appIcon: AppIcons
    var size: CGFloat
    var text: String? { willSet { self.label.text = newValue } }
    var stackAxis: NSLayoutConstraint.Axis
    var color: UIColor
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = self.text
        label.font = Fonts.detailsSunTimeFont
        label.textColor = self.color
        return label
    }()
    
    private lazy var icon = getAppIcon(self.appIcon, size, color)

    
    init (
        appIcon: AppIcons,
        size: CGFloat = 24,
        text: String? = "--",
        stackAxis: NSLayoutConstraint.Axis = .vertical,
        color: UIColor = Colors.mainTextColor
    ) {
        self.appIcon = appIcon
        self.size = size
        self.text = text
        self.stackAxis = stackAxis
        self.color = color
        
        super.init(frame: .zero)
                
        addArrangedSubview(icon)
        addArrangedSubview(label)

        axis = self.stackAxis
        spacing = 4
        alignment = .center
        distribution = .equalCentering
    }
        
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
