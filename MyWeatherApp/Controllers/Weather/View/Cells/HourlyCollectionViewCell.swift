//
//  HourlyForecastView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 03.08.2022.
//

import UIKit
import SnapKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyCollectionViewCell"
    
    
    var currentWeather: WeatherModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let itemsPerRow: CGFloat = 6
    
    let sectionInsets = UIEdgeInsets(
        top: 0,
        left: 8,
        bottom: 0,
        right: 8
    )
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = sectionInsets.left
        layout.sectionInset = sectionInsets
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var icon = getAppIcon(.clock, 18)
    
    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "Прогноз на 24 часа",
            font: Fonts.tenDayTitleFont,
            textColor: Colors.mediumTextColor
        )
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourForecastCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourForecastCollectionViewCell.identifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        
        contentView.getShadow(contentView)
        contentView.addSubviews(icon, titleLabel, collectionView)
        
        icon.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.width.height.equalTo(18)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.top.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureOfCell(weather: WeatherModel?) {
        guard let wthr = weather else { return }
        currentWeather = wthr
    }
}

extension HourlyCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourForecastCollectionViewCell.identifier, for: indexPath) as? HourForecastCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureOfCell(currentWeather, at: indexPath.item)
        return cell
    }
    
}

extension HourlyCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = (availableWidth / itemsPerRow) - sectionInsets.left / itemsPerRow
        return CGSize(width: widthPerItem, height: 130)
    }
}
