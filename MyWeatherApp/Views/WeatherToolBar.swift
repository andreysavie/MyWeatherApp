//
//  WeatherToolBar.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 01.08.2022.
//

import UIKit
import SnapKit

class WeatherToolBar: UIToolbar {
    
    // MARK: - Properties
    
    private lazy var detailWeatherButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "safari")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        addSubview(button)
        return button
    }()
    
    private lazy var locationListButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "list")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .lightGray
        addSubview(button)
        return button
    }()
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        barTintColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - Layout Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        
        detailWeatherButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        locationListButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
}
