//
//  PageViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import UIKit

let cities: [CityModel] = [CityModel(name: "Ростов-на-Дону", latitude: 21.13, longitude: 43.34)]

class MainScreenPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    
    private lazy var searchCityBarButtonItem: UIBarButtonItem = {
        let image = UIImage(
            systemName: "location",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?
            .withTintColor(Colors.darkTextColor, renderingMode: .alwaysOriginal
            )
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var settingsBarButtonItem: UIBarButtonItem = {
        let image = UIImage(
            systemName: "gearshape",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?
            .withTintColor(Colors.darkTextColor, renderingMode: .alwaysOriginal
            )
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = searchCityBarButtonItem
        self.navigationItem.leftBarButtonItem = settingsBarButtonItem
        
                
        self.dataSource = self
                
        if let controller = self.pageViewController(for: 0) {
                        
            setViewControllers([controller], direction: .forward, animated: true)
        }
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLayout() 
    }
    
    func setupLayout() {
        let appearanceNavigationBar = UINavigationBarAppearance()
        appearanceNavigationBar.configureWithOpaqueBackground()
        appearanceNavigationBar.backgroundColor = Colors.navigationBarColor
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = Colors.navigationBarColor
        self.navigationController?.navigationBar.standardAppearance = appearanceNavigationBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

    }
    
    // MARK: OBJC METHODS
    
    @objc
    private func searchButtonPressed() {
//        let controller = SearchCityViewController()
//        self.navigationController?.pushViewController(controller, animated: true)
        let controller = UINavigationController(rootViewController: SearchCityViewController())
        present(controller, animated: true)
    }
    
    @objc
    private func settingsButtonPressed() {
        let controller = UINavigationController(rootViewController: SettingsViewController(style: .insetGrouped))
        present(controller, animated: true)
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let index = ((viewController as? WeatherViewController)?.index ?? 0) - 1
        return self.pageViewController(for: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let index = ((viewController as? WeatherViewController)?.index ?? 0) + 1
        return self.pageViewController(for: index)
    }
        
    func pageViewController (for index: Int) -> UIViewController? {
        
        if index < 0 {
            return nil
        }
        
        if index >= cities.count {
            return nil
        }
        
        let controller = WeatherViewController(city: cities[index], index: index)
        
        self.title = cities[index].name
        
        return controller
        
        
    }

}
