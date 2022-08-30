//
//  TabBar.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 30.08.2022.
//

import Foundation
import UIKit
import SnapKit

class ToolBar: UIToolbar {
    
    var settingsCallBack: (() -> ())?
    var locationsCallBack: (() -> ())?

    // MARK: - Properties
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(
            systemName: "gearshape",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?
            .withTintColor(Colors.darkTextColor, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(settingsDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var locationListButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(
            systemName: "list.bullet",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?
            .withTintColor(Colors.darkTextColor, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(locationsDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Callback
    internal var detailWeatherButtonDidTap: (() -> ())?
    internal var locationListButtonDidTap: (() -> ())?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        barTintColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLayout() {
        
        addSubviews(settingsButton, locationListButton)
        
        settingsButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        locationListButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc
    private func settingsDidTap() {
        settingsCallBack?()
    }
    
    @objc
    private func locationsDidTap() {
        locationsCallBack?()
    }

}
