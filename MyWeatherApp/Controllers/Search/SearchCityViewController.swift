//
//  SearchCityViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit
import MapKit

class SearchCityViewController: UIViewController {

    private var cities = [CityModel]()

//    private var cities: [CityModel] = [
//
//        CityModel(name: "Ростов-на-Дону", longitude: 39.720358, latitude: 47.222078),
//        CityModel(name: "Москва", longitude: 37.617698, latitude: 55.755864),
//        CityModel(name: "Самара", longitude: 50.100202, latitude: 53.195878),
//        CityModel(name: "Курск", longitude: 36.193015, latitude: 51.730846),
//
//    ]
    
    private var matchingItems: [MKMapItem] = []
    
    private lazy var citiesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var searchTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.isHidden = true
        table.alpha = 0
        table.isUserInteractionEnabled = false
        return table
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
    
    
    
    private lazy var searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.searchTextField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        search.searchBar.searchTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        search.searchBar.placeholder = "Введите название города"
        return search
    }()
    
    
    @objc func editingDidBegin() {
        
        UIView.animate(
            withDuration: 0.3) { [weak citiesCollectionView, weak searchTableView] in
                citiesCollectionView?.alpha = 0
                searchTableView?.alpha = 1
            } completion: { _ in
                self.view.setNeedsLayout()
//                self.view.layer.layoutIfNeeded()
                self.citiesCollectionView.isHidden = true
                self.citiesCollectionView.isUserInteractionEnabled = false
                self.searchTableView.isHidden = false
                self.searchTableView.isUserInteractionEnabled = true
            }
    }
    
    @objc func editingDidEnd() {
        
        matchingItems.removeAll()
        citiesCollectionView.isHidden = false
        searchTableView.reloadData()
        
        UIView.animate(
            withDuration: 0.3) { [weak citiesCollectionView, weak searchTableView] in
                citiesCollectionView?.alpha = 1
                searchTableView?.alpha = 0
            } completion: { _ in
                self.citiesCollectionView.isUserInteractionEnabled = true
                self.searchTableView.isHidden = true
                self.searchTableView.isUserInteractionEnabled = false
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        citiesCollectionView.register(
            CityCollectionViewCell.self,
            forCellWithReuseIdentifier: CityCollectionViewCell.identifier
        )
        
        citiesCollectionView.dataSource = self
        citiesCollectionView.delegate = self
                
        searchTableView.dataSource = self
        searchTableView.delegate = self

        setupLayout()
        
        title = "Погода"
        navigationItem.titleView?.tintColor = Colors.darkTextColor
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }
    
    func setupLayout() {
        
        view.addSubviews(citiesCollectionView, searchTableView)

        citiesCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchController.searchBar.frame.minY).offset(16)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(52)
        }
        
        
    }
    
    //    func updateSearchResults(for searchController: UISearchController) {
    //        <#code#>
    //    }
    
    
    
}

extension SearchCityViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell else { return UICollectionViewCell() }
        cell.configureOfCell(city: cities[indexPath.item])
        return cell
    }
    
}

extension SearchCityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: floor(collectionView.frame.width - 32), height: 130)
    }
}

extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell (style: .default, reuseIdentifier: nil)
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()

        let selectedItem = matchingItems[indexPath.row].placemark
        
        let locality = selectedItem.locality ?? ""
        let subLocality = selectedItem.subLocality ?? ""
        let thoroughfare = selectedItem.thoroughfare ?? ""
        content.text = locality
        content.secondaryText = !subLocality.isEmpty ? subLocality : thoroughfare
        cell.tintColor = .black
        cell.backgroundColor = .white
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectItem = matchingItems[indexPath.row].placemark
        let coordinate = selectItem.coordinate
        let locality = selectItem.locality ?? ""
        let city = CityModel(name: locality, longitude: coordinate.longitude, latitude: coordinate.latitude)
        cities.append(city) // connect CoreData
        citiesCollectionView.reloadData()
        searchController.isActive = false
        matchingItems.removeAll()
        searchTableView.reloadData()

                
//        DataManager.shared.addLocation(location)
//        DataManager.shared.fetchWeather(from: coordinate,
//                                        with: locality,
//                                        completionHandler: nil)
//    })
//}
    }
}


extension SearchCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        let search = MKLocalSearch(request: request)
        search.start { (response, _) in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.searchTableView.reloadData()
        }
    }
}
