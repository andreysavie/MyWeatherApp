//
//  CustomButton.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import UIKit

final class CustomButton: UIButton {
    
    let title: String
    let font: UIFont
    let normalColor: UIColor
    let highlightedColor: UIColor
    
    var tapAction: (() -> Void)?
    
    init (
        normalColor: UIColor = Colors.darkTextColor,
        highlightedColor: UIColor = Colors.mediumTextColor,
        title: String,
        font: UIFont
    ) {
        self.normalColor = normalColor
        self.highlightedColor = highlightedColor
        self.title = title
        self.font = font
        
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = font
        setTitleColor(normalColor, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)

        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed() {
            tapAction?()
    }
}
