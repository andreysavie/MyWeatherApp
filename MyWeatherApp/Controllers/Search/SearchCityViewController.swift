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

class SearchCityViewController: UIViewController, FetchWeatherDelegate {
    
    // MARK: PROPERTIES
    
    var didDisappearCallback: (() -> ())?
    var didChangeCallback: (() -> ())?
    var didChooseCityCallback: ((Int) -> ())?

    private var matchingItems: [MKMapItem] = []
//    private var savedCities = [CityModel]()
    private var savedCities = [CityModelEntity]()
    
    private var fetchedResultsController = CoreDataManager.shared.fetchedResultsController
    private var weatherManager = NetworkManager()
    private var displayWeather: [WeatherModel?] = []
    
    private lazy var citiesTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.isScrollEnabled = true
        table.isUserInteractionEnabled = true
        return table
    }()
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isHidden = true
        tableView.alpha = 0
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = .clear
        return tableView
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
        
        citiesTableView.register(
            CityTableViewCell.self,
            forCellReuseIdentifier: CityTableViewCell.identifier)
        
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        weatherManager.delegate = self
        fetchedResultsController.delegate = self
        searchController.searchResultsUpdater = self
        
        setupLayout()
        fetchWeatherData()
        
        title = "Погода"
        navigationItem.titleView?.tintColor = Colors.darkTextColor
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
                
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        didDisappearCallback?()
    }
    
    
    // MARK: LAYOUT
    
    func setupLayout() {
        
        view.addSubviews(citiesTableView, searchTableView)
        
        citiesTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchController.searchBar.frame.minY).offset(16)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(52)
        }
    }
    
    // MARK: METHODS
    
    func fetchWeatherData() {
//        guard let savedCities = CoreDataManager.shared.fetchCities() else { return }
        guard let savedCities = fetchedResultsController.fetchedObjects else { return }
        
        savedCities.forEach({ print("💀\(String(describing: $0.name))") })
                
        self.savedCities = savedCities
        displayWeather.removeAll()
        
        for _ in 0..<savedCities.count {
            displayWeather.append(nil)
        }
        
        for (i, city) in self.savedCities.enumerated() {
            weatherManager.fetchWeather(by: city, at: i)
        }
        
    }
    
    // MARK: OBJC METHODS
    
    @objc func editingDidBegin() {
        
        UIView.animate(
            withDuration: 0.3) { [weak citiesTableView, weak searchTableView] in
                citiesTableView?.alpha = 0
                searchTableView?.alpha = 1
            } completion: { _ in
                self.view.layoutIfNeeded()
                self.citiesTableView.isHidden = true
                self.citiesTableView.isUserInteractionEnabled = false
                self.searchTableView.isHidden = false
                self.searchTableView.isUserInteractionEnabled = true
            }
    }
    
    @objc func editingDidEnd() {
        
        matchingItems.removeAll()
        citiesTableView.isHidden = false
        searchTableView.reloadData()
        
        UIView.animate(
            withDuration: 0.3) { [weak citiesTableView, weak searchTableView] in
                citiesTableView?.alpha = 1
                searchTableView?.alpha = 0
            } completion: { _ in
                self.view.layoutIfNeeded()
                self.citiesTableView.isUserInteractionEnabled = true
                self.searchTableView.isHidden = true
                self.searchTableView.isUserInteractionEnabled = false
            }
    }
    
}

// MARK: EXTENSIONS

// EXTENSION: TableView

extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case citiesTableView:
            return fetchedResultsController.sections?.count ?? 0
        case searchTableView:
            return matchingItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableView == citiesTableView else { return 1 }
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
            
        case citiesTableView:
            guard
                displayWeather[indexPath.row] != nil,
                let weatherDataForCell = displayWeather[indexPath.row],
                let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
                return CityTableViewCell()
                
            }
            
            cell.configureOfCell(weather: weatherDataForCell)
            cell.layoutIfNeeded()
            return cell
            
        case searchTableView:
            
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
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == citiesTableView ? 150 : tableView.rowHeight
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
            
        case searchTableView:
            
            let selectItem = matchingItems[indexPath.row].placemark
            let coordinate = selectItem.coordinate
            let locality = selectItem.locality ?? ""
            let city = CityModel(name: locality, longitude: coordinate.longitude, latitude: coordinate.latitude)
            
            searchController.isActive = false
            
            self.displayWeather.append(nil)
            self.displayWeather[self.displayWeather.count - 1]?.cityName = city.name
            CoreDataManager.shared.saveCity(city: city)
            
            self.fetchWeatherData()
            
        default:
            didChooseCityCallback?(indexPath.row)
            dismiss(animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return tableView == citiesTableView ? true : false
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard tableView == citiesTableView else { return nil }
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, completion in
            
            let context = self.fetchedResultsController.managedObjectContext
            context.delete(self.fetchedResultsController.object(at: indexPath))
            completion(true)
            
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        deleteAction.image = UIGraphicsImageRenderer(size: CGSize(width: 120, height: 120)).image { _ in
            UIImage(named: "deleteAction")?.draw(in: CGRect(x: 0, y: 0, width: 120, height: 120))
        }
        deleteAction.backgroundColor = UIColor(white: 1, alpha: 0)
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

// EXTENSION: FetchedResultsController

extension SearchCityViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        citiesTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        print ("changed!")
        
        switch type {
        case .insert:
            citiesTableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            citiesTableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            citiesTableView.insertRows(at: [newIndexPath!], with: .fade)
            didChangeCallback?()
        case .delete:
            citiesTableView.deleteRows(at: [indexPath!], with: .fade)
            didChangeCallback?()
        case .update:
            guard let indexPath = indexPath, let cell = citiesTableView.cellForRow(at: indexPath) as? CityTableViewCell else { return }
            
            let weatherDataForCell = displayWeather[indexPath.row]
            cell.configureOfCell(weather: weatherDataForCell)
        case .move:
            guard
                let indexPath = indexPath,
                let newIndexPath = newIndexPath,
                let cell = citiesTableView.cellForRow(at: indexPath) as? CityTableViewCell
            else { return }
            
            let weatherDataForCell = displayWeather[indexPath.row]
            cell.configureOfCell(weather: weatherDataForCell)
            
            citiesTableView.moveRow(at: indexPath, to: newIndexPath)
            
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        citiesTableView.endUpdates()
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

// EXTENSION: NetworkManagerDelegate

extension SearchCityViewController: NetworkManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: NetworkManager, weather: WeatherModel, at position: Int) {
        
        DispatchQueue.main.async {
            self.displayWeather[position] = weather
            let indexPath = IndexPath(row: position, section: 0)
            
            self.displayWeather[indexPath.row]?.cityName = self.savedCities[indexPath.row].name ?? "unknown"
            self.citiesTableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    func didFailWithError(error: Error) {
        
//        for (i, weatherModel) in self.displayWeather.enumerated() {
//            if weatherModel == nil {
//                self.deleteItem(at: i)
//                self.displayWeather.remove(at: i)
//                self.tableView?.reloadData()
//            }
//        }
        
    }
}


