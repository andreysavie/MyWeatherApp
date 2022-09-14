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
    let text: String?
    
    init (
        icon: AppIcons,
        text: String? = "--"
    ) {
        self.icon = icon
        self.text = text
        
        super.init(frame: .zero)
        
        let icon = getAppIcon(self.icon, 28)
        let label = UILabel()
        label.text = self.text
        label.textColor = .white
        
        addArrangedSubview(icon)
        addArrangedSubview(label)

        axis = .vertical
        spacing = 4
        alignment = .center
        distribution = .equalCentering
    }
        
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
