//
//  PageViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import UIKit
import SnapKit

class MainScreenPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var cities = CoreDataManager.shared.fetchCities() {
        didSet {
            view.setNeedsLayout()
            view.layoutIfNeeded()
            cities?.forEach({ print("💀\($0)") })
            self.pageControl.numberOfPages = cities?.count ?? 1
        }
    }
    
    private let searchViewController = SearchCityViewController()
    private let settingsViewController = SettingsViewController(style: .insetGrouped)

    private var fetchedResultsController = CoreDataManager.shared.fetchedResultsController
    
//    private lazy var searchCityBarButtonItem: UIBarButtonItem = {
//        let image = UIImage(
//            systemName: "location",
//            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?
//            .withTintColor(Colors.darkTextColor, renderingMode: .alwaysOriginal
//            )
//        let button = UIButton()
//        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
//        return UIBarButtonItem(customView: button)
//    }()
//
//    private lazy var settingsBarButtonItem: UIBarButtonItem = {
//        let image = UIImage(
//            systemName: "gearshape",
//            withConfiguration: UIImage.SymbolConfiguration(pointSize: 32))?
//            .withTintColor(Colors.darkTextColor, renderingMode: .alwaysOriginal
//            )
//        let button = UIButton()
//        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
//        return UIBarButtonItem(customView: button)
//    }()
    
    private lazy var toolBar: ToolBar = {
      let toolBar = ToolBar(frame: .zero)
      view.addSubview(toolBar)
      return toolBar
    }()
    
    private lazy var pageControl: UIPageControl = {
      let pager = UIPageControl(frame: .zero)
        pager.numberOfPages = 1
        pager.currentPageIndicatorTintColor = .black
        pager.pageIndicatorTintColor = .lightGray
        pager.numberOfPages = cities?.count ?? 1
      return pager
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.rightBarButtonItem = searchCityBarButtonItem
//        self.navigationItem.leftBarButtonItem = settingsBarButtonItem
        
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        
        self.dataSource = self
        
        setController()
        setupLayout()
        
        searchViewController.didChangeCallback = { [weak self] in
            guard let self = self else { return }
                self.fetchCities()
            self.setController()
            }
        
        searchViewController.didChooseCityCallback = { [weak self] num in
            guard let self = self else { return }
            self.setController(num)
        }
        
        
        toolBar.settingsCallBack = { [weak self] in
            guard let self = self else { return }
            self.settingsButtonPressed()
        }
        
        toolBar.locationsCallBack = { [weak self] in
            guard let self = self else { return }
            self.locationsButtonPressed()
        }

    }
    
    func setController(_ number: Int = 0) {
        if let controller = self.pageViewController(for: number) {
            setViewControllers([controller], direction: .forward, animated: true)
        }
    }

    
    func setupLayout() {
        
        view.addSubview(toolBar)
        toolBar.addSubview(pageControl)
        
        let appearanceNavigationBar = UINavigationBarAppearance()
        appearanceNavigationBar.configureWithOpaqueBackground()
        appearanceNavigationBar.backgroundColor = .white
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearanceNavigationBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

        toolBar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(75)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func fetchCities() {
        self.cities?.removeAll()
        self.cities = CoreDataManager.shared.fetchCities()
    }
    
    // MARK: OBJC METHODS
    
    private func settingsButtonPressed() {
        let navController = UINavigationController(rootViewController: settingsViewController)
        present(navController, animated: true)
    }
    
    private func locationsButtonPressed() {
        let navController = UINavigationController(rootViewController: searchViewController)
        present(navController, animated: true)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewController = viewController as? WeatherViewController else { return nil }
        let index = viewController.index
        
        return index > 0 ? self.pageViewController(for: index - 1) : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard
            let viewController = viewController as? WeatherViewController,
            let cities = cities 
        else { return nil }
        
        
        let index = viewController.index
        
        return index < (cities.count) - 1 ? self.pageViewController(for: index + 1) : nil
    }
        
    func pageViewController (for index: Int) -> UIViewController? {
        
        guard let cities = cities else { return nil }

        
        if index < 0 {
            return nil
        }
        
        if index >= cities.count {
            return nil
        }
        
        let controller = WeatherViewController(city: cities[index], index: index)
        self.title = cities[index].name
        pageControl.currentPage = index
        
        return controller
        
    }

}
