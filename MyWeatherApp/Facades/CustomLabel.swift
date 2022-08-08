//
//  CustomLabel.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 08.08.2022.
//

import Foundation
import UIKit

final class CustomLabel: UILabel {
    
    let customNumberOfLines: Int
    let customText: String
    let customFont: UIFont
    let customTextColor: UIColor
    
    init (
        numberOfLines: Int = 2,
        text: String,
        font: UIFont,
        textColor: UIColor
    ) {
        self.customNumberOfLines = numberOfLines
        self.customText = text
        self.customFont = font
        self.customTextColor = textColor
        
        super.init(frame: .zero)
        
        self.numberOfLines = customNumberOfLines
        self.text = customText
        self.font = customFont
        self.textColor = customTextColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
