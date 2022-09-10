//
//  LoadingCityTableViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 29.08.2022.
//

import UIKit
import SnapKit

class LoadingCityTableViewCell: UITableViewCell {
    
    static let identifier = "LoadingCityTableViewCell"
    
    // MARK: PROPERTIES
    
    private lazy var cityNameLoadView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var cityTimeLoadView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var cityForecastLoadView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var cityTempLoadView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var cityLowHeightTempsLoadView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: INITS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS
    
    private func setupLayout() {
        
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 16
        
        
        contentView.addSubviews(
            cityNameLoadView,
            cityTimeLoadView,
            cityForecastLoadView,
            cityTempLoadView,
            cityLowHeightTempsLoadView
        )
        
        cityTempLoadView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
        
        cityNameLoadView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.trailing.equalTo(contentView.snp.centerX)
        }
        
        cityTimeLoadView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(cityNameLoadView.snp.bottom).offset(4)
            make.trailing.equalTo(contentView.snp.centerX)
        }
        
        cityForecastLoadView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
            make.trailing.equalTo(contentView.snp.centerX)
        }
        
        cityLowHeightTempsLoadView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(16)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
}
