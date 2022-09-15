//
//  PartDetailsWeatherViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 15.09.2022.
//

import Foundation
import UIKit
import SnapKit

class PartDetailsWeatherViewController: UIViewController {
        
    private var currentWeather: WeatherModel? { didSet { collectionView.reloadData() } }
    private var city: CityModelEntity? { didSet { collectionView.reloadData() } }

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 8,
            left: 16,
            bottom: 8,
            right: 16)
        return layout
    }()
    
//    init (for weather: WeatherModel?, in city: CityModel) {
    init (for weather: WeatherModel?, in city: CityModelEntity) {
        self.currentWeather = weather
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            PartCollectionViewCell.self,
            forCellWithReuseIdentifier: PartCollectionViewCell.identifier
        )
        
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}


extension PartDetailsWeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartCollectionViewCell.identifier, for: indexPath) as? PartCollectionViewCell else { return UICollectionViewCell() }
            switch indexPath.item {
            case 0: cell.configureOfCell(currentWeather, of: indexPath.item, for: .day)
            case 1: cell.configureOfCell(currentWeather, of: indexPath.item, for: .night)
            default: break
            }
            
            return cell
    }
    
}

extension PartDetailsWeatherViewController: UICollectionViewDelegate {
    
}

extension PartDetailsWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 300
        var width: CGFloat = collectionView.frame.width - 16

        return CGSize(width: floor(width), height: height)
    }

}
