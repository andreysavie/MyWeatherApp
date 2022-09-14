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
    
    internal var index: Int
    
    private var city: CityModelEntity?
    private var hourly = [HourlyForecast]()
    
    private var weatherManager = NetworkManager()
    private var savedCities = [CityModel]()
    private var currentWeather: WeatherModel?
    
    // MARK: INITS
    
    init (city: CityModelEntity, index: Int) {
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
    }
    
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
        guard let city = self.city else { return }
        weatherManager.fetchWeather(by: city, at: 0)
    }
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 2: return currentWeather?.daily.count ?? 0
        default: return 1
        }
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
                guard let self = self, let city = self.city else { return }
                let viewController = DetailsWeatherViewController(for: self.currentWeather, in: city)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
            cell.configureOfCell(weather: currentWeather)
            return cell
            
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCollectionViewCell.identifier, for: indexPath) as? DailyCollectionViewCell else { return UICollectionViewCell() }
            cell.configureOfCell(currentWeather, at: indexPath.item)
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
            height = self.view.safeAreaLayoutGuide.layoutFrame.height * 0.5
        case 1:
            height = 150
        case 2:
            height = 80
        default:
            break
        }
        return CGSize(width: floor(collectionView.frame.width - 16), height: height)
    }
}


