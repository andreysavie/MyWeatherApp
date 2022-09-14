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
    
    private var currentWeather: WeatherModel? { didSet { collectionView.reloadData() } }
    
    private let itemsPerRow: CGFloat = 4
    private let sectionInsets = UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 8 )
        
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = sectionInsets.left
        layout.sectionInset = sectionInsets
        layout.scrollDirection = .horizontal
        return layout
    }()
    
//    private lazy var titleLabel: CustomLabel = {
//        let label = CustomLabel(
//            numberOfLines: 1,
//            text: "Прогноз на 24 часа",
//            font: Fonts.tenDayTitleFont,
//            textColor: Colors.mediumTextColor)
//        return label
//    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourForecastCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        contentView.backgroundColor = .clear
        contentView.addSubview(collectionView)
                
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
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
        let paddingWidth = sectionInsets.right * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = (availableWidth / itemsPerRow) - sectionInsets.right / itemsPerRow
        return CGSize(width: widthPerItem, height: 150)
    }
}
