//
//  DetailsWeatherViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit

class DetailsWeatherViewController: UIViewController {
    
    private let itemsPerRow: CGFloat = 2
    
    private var currentWeather: WeatherModel? { didSet { collectionView.reloadData() } }
    private var city: CityModel? { didSet { collectionView.reloadData() } }


    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
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
    
    init (for weather: WeatherModel?, in city: CityModel) {
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
            DetailsForecastCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailsForecastCollectionViewCell.identifier
        )
        
        collectionView.register(
            DetailsChartCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailsChartCollectionViewCell.identifier
        )

        collectionView.register(
            DetailsBlockCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailsBlockCollectionViewCell.identifier
        )
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
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


extension DetailsWeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return BlockTitle.allCases.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsForecastCollectionViewCell.identifier, for: indexPath) as? DetailsForecastCollectionViewCell else { return UICollectionViewCell() }
            cell.configureOfCell(currentWeather, for: city)
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsChartCollectionViewCell.identifier, for: indexPath) as? DetailsChartCollectionViewCell else { return UICollectionViewCell() }
            cell.configureOfCell(currentWeather)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsBlockCollectionViewCell.identifier, for: indexPath) as? DetailsBlockCollectionViewCell else { return UICollectionViewCell() }
            cell.configureOfCell(currentWeather, for: indexPath.item)
            return cell
            
        default:
            return UICollectionViewCell()

        }
    }
    
    
}

extension DetailsWeatherViewController: UICollectionViewDelegate {
    
}

extension DetailsWeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        var width: CGFloat = 0
        
        let paddingWidth: CGFloat = 8
        let availableWidth = UIScreen.main.bounds.width - 32 - paddingWidth
        let widthPerItem = (availableWidth / itemsPerRow)


        switch indexPath.section {
        case 0:
            height = 180
            width = collectionView.frame.width - 32
        case 1:
            height = 260
            width = collectionView.frame.width - 32
        case 2:
            height = widthPerItem
            width = widthPerItem
        default:
            break
        }
        return CGSize(width: floor(width), height: height)
    }


}
