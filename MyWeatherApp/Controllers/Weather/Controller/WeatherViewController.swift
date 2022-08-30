//
//  WeatherViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 01.08.2022.
//

import UIKit
import SnapKit

protocol FetchWeatherDelegate {
    func fetchWeatherData()
}

class WeatherViewController: UICollectionViewController, FetchWeatherDelegate {
    
    // MARK: PROPERTIES
    
    var city: CityModel
    var hourly = [HourlyForecast]()
    var index: Int
    
    private var weatherManager = NetworkManager()
    private var savedCities = [CityModel]()
    
    
    var currentWeather: WeatherModel?
    
//    private lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .clear
//        collectionView.isScrollEnabled = true
//        collectionView.showsVerticalScrollIndicator = false
//        return collectionView
//    }()
    
//    static let layout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 16
//        layout.scrollDirection = .vertical
//        layout.sectionInset = UIEdgeInsets(
//            top: 16,
//            left: 0,
//            bottom: 0,
//            right: 0)
//        return layout
//    }()
    
    // MARK: INITS
    
    init (city: CityModel, index: Int) {
        self.city = city
        self.index = index
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 16,
            left: 0,
            bottom: 0,
            right: 0)

        super.init(collectionViewLayout: layout)
//        super.init(nibName: nil, bundle: nil)
    }
    
    
    
//    override init(collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(collectionViewLayout: layout)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(
            CurrentWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.identifier
        )
        
        collectionView.register(
            HourlyCollectionViewCell.self,
            forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier
        )
        
        collectionView.register(
            DailyCollectionViewCell.self,
            forCellWithReuseIdentifier: DailyCollectionViewCell.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        weatherManager.delegate = self
        
        fetchWeatherData()
        setupLayout()
        
    }
    
    
    // MARK: LAYOUT

    private func setupLayout() {
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func fetchWeatherData() {
        weatherManager.fetchWeather(by: city, at: 0)
    }
    
    
//    // MARK: OBJC METHODS
//    
//    @objc
//    private func searchButtonPressed() {
//        let controller = SearchCityViewController()
//        self.navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    @objc
//    private func settingsButtonPressed() {
//        let controller = UINavigationController(rootViewController: SettingsViewController(style: .insetGrouped))
//        present(controller, animated: true)
//        
//    }
}

// MARK: EXTENSIONS

extension WeatherViewController: NetworkManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: NetworkManager, weather: WeatherModel, at position: Int) {
        DispatchQueue.global().async {
            self.currentWeather = weather
            DispatchQueue.main.sync {
                self.collectionView.reloadData()
            }
//            let indexPath = IndexPath(row: position, section: 0)
            // Put chosen city name from addCity autoCompletion into weather data model
//            self.displayWeather[indexPath.row]?.cityName = self.savedCities[indexPath.row].name
//            self.tableView?.reloadRows(at: [indexPath], with: .fade)
        }
    }

    func didFailWithError(error: Error) {
//        let removeEmptyCells: ((UIAlertAction) -> (Void)) = { _ in
//            for (i, weatherModel) in self.displayWeather.enumerated() {
//                if weatherModel == nil {
//                    self.deleteItem(at: i)
//                    self.displayWeather.remove(at: i)
//                    self.tableView?.reloadData()
//                }
//            }
//        }
//
//        DispatchQueue.main.async {
//            let alert = AlertViewBuilder()
//                .build(title: "Oops", message: error.localizedDescription, preferredStyle: .alert)
//                .build(title: "Ok", style: .default, handler: removeEmptyCells)
//                .content
//            self.present(alert, animated: true, completion: nil)
//        }
    }
//}
//
//extension WeatherViewController: UICollectionViewDataSource {

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.identifier, for: indexPath) as? CurrentWeatherCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureOfCell(weather: currentWeather, for: city)
            
            cell.detailsButtonAction = { [weak self] in
                guard let self = self else { return }
                let viewController = DetailsWeatherViewController(for: self.currentWeather, in: self.city)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            return cell
           
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
            cell.configureOfCell(weather: currentWeather)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCollectionViewCell.identifier, for: indexPath) as? DailyCollectionViewCell else { return UICollectionViewCell() }
            cell.configureOfCell(weather: currentWeather)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}


extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        
        switch indexPath.section {
        case 0:
            height = self.view.safeAreaLayoutGuide.layoutFrame.height * 0.4
        case 1:
            height = self.view.safeAreaLayoutGuide.layoutFrame.height * 0.2
        case 2:
            height = self.view.safeAreaLayoutGuide.layoutFrame.height * 0.8
        default:
            break
        }
        return CGSize(width: floor(collectionView.frame.width - 32), height: height)
    }
}

    
