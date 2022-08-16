//
//  HourlyForecastView.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 15.08.2022.
//

import UIKit
import SnapKit

class HourlyForecastView: UIView {
    
    // MOK
    var city: CityModel = CityModel(name: "Ростов-на-Дону", longitude: 39.455768, latitude: 47.153251)
    
    var currentWeather: WeatherModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var weatherManager = NetworkManager()

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
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourForecastCollectionViewCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    init (weather: WeatherModel?  = nil) {
        self.currentWeather = weather
        super.init(frame: .zero)
        
        collectionView.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourForecastCollectionViewCell.identifier)
        
        setupLayout()
    }
    
//    override init (frame: CGRect) {
//        super.init(frame: .zero)
//
//        collectionView.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourForecastCollectionViewCell.identifier)
//
//        setupLayout()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
                
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

extension HourlyForecastView: UICollectionViewDataSource {
    
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

extension HourlyForecastView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = (availableWidth / itemsPerRow) - sectionInsets.left / itemsPerRow
        return CGSize(width: widthPerItem, height: 130)
    }
    
}


