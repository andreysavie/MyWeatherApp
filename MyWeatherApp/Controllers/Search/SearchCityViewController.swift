//
//  SearchCityViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit
import MapKit
import CoreData

class SearchCityViewController: UIViewController {

    // MARK: PROPERTIES
    
    private var matchingItems: [MKMapItem] = []
    private var blockOperations: [BlockOperation] = []
    private var fetchedResultsController = CoreDataManager.shared.fetchedResultsController

    private lazy var citiesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.isHidden = true
        tableView.alpha = 0
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = .clear
        return tableView
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
    
    // MARK: INITS

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
        
        fetchedResultsController.delegate = self

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
    
    // MARK: LAYOUT

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
    
    // MARK: OBJC METHODS
    
    @objc func editingDidBegin() {
        
        UIView.animate(
            withDuration: 0.3) { [weak citiesCollectionView, weak searchTableView] in
                citiesCollectionView?.alpha = 0
                searchTableView?.alpha = 1
            } completion: { _ in
                self.view.setNeedsLayout()
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
        
}
// MARK: EXTENSIONS

// EXTENSION: TableView

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
        
        CoreDataManager.shared.saveCity(city: city)

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


// EXTENSION: CollectionView

extension SearchCityViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell else { return UICollectionViewCell() }
        
        let city = fetchedResultsController.object(at: indexPath)

        cell.configureOfCell(city: city)

        return cell
    }
}

extension SearchCityViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: floor(collectionView.frame.width - 32), height: 130)
    }
}

// EXTENSION: NSFetchedResultsController

extension SearchCityViewController: NSFetchedResultsControllerDelegate {
        
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        let op: BlockOperation
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            op = BlockOperation { self.citiesCollectionView.insertItems(at: [newIndexPath]) }

        case .delete:
            guard let indexPath = indexPath else { return }
            op = BlockOperation { self.citiesCollectionView.deleteItems(at: [indexPath]) }
        case .move:
            guard let indexPath = indexPath,  let newIndexPath = newIndexPath else { return }
            op = BlockOperation { self.citiesCollectionView.moveItem(at: indexPath, to: newIndexPath) }
        case .update:
            guard let indexPath = indexPath else { return }
            op = BlockOperation { self.citiesCollectionView.reloadItems(at: [indexPath]) }
        @unknown default:
            fatalError()
        }

        blockOperations.append(op)
    }

    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        citiesCollectionView.performBatchUpdates({
            self.blockOperations.forEach { $0.start() }
        }, completion: { finished in
            self.blockOperations.removeAll(keepingCapacity: false)
        })
    }
}


// EXTENSION: SearchController

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


