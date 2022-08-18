//
//  SearchCityViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit

class SearchCityViewController: UIViewController {

    var cities: [CityModel] = [
    
        CityModel(name: "Ростов-на-Дону", longitude: 39.720358, latitude: 47.222078),
        CityModel(name: "Москва", longitude: 37.617698, latitude: 55.755864),
        CityModel(name: "Самара", longitude: 50.100202, latitude: 53.195878),
        CityModel(name: "Курск", longitude: 36.193015, latitude: 51.730846),
    
    ]
    
    
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
            top: 0,
            left: 16,
            bottom: 0,
            right: 16)
        return layout
    }()
    
    

    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            CityCollectionViewCell.self,
            forCellWithReuseIdentifier: CityCollectionViewCell.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupLayout()
        
        title = "Погода"
        navigationItem.titleView?.tintColor = Colors.darkTextColor
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        
//        searchController.searchResultsUpdater = self
    }
    
    func setupLayout() {
        
        view.addSubview(collectionView)
//
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchController.searchBar.frame.minY).offset(16)
        }
        
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
//    }

    

}

extension SearchCityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    

}

extension SearchCityViewController: UICollectionViewDelegate {

}

extension SearchCityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: floor(collectionView.frame.width - 32), height: 130)
    }
}
