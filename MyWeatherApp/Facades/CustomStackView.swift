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
    
    let icon: AppIcons
    let size: CGFloat
    let text: String?
    let stackAxis: NSLayoutConstraint.Axis
    let color: UIColor
    
    init (
        icon: AppIcons,
        size: CGFloat = 24,
        text: String? = "--",
        stackAxis: NSLayoutConstraint.Axis = .vertical,
        color: UIColor = Colors.mainTextColor
    ) {
        self.icon = icon
        self.size = size
        self.text = text
        self.stackAxis = stackAxis
        self.color = color
        
        super.init(frame: .zero)
        
        let icon = getAppIcon(self.icon, size, color)
        let label = UILabel()
        label.text = self.text
        label.font = Fonts.detailsSunTimeFont
        label.textColor = self.color
        
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
