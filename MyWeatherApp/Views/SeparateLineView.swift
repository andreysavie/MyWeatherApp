//
//  SeparateLineView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 03.08.2022.
//

import UIKit
import SnapKit

class SeparateLineView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = WeatherColor.separateLineColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Methods
    internal func makeConstraints(atBottom bottom: ConstraintRelatableTarget) {
        self.snp.makeConstraints { make in
            
            if let superview = superview {
                make.leading.trailing.equalTo(superview).inset(16)
            }
            
            make.height.equalTo(0.7)
            make.bottom.equalTo(bottom).offset(-50)
        }
    }
}
