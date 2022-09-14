//
//  PageViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import UIKit
import SnapKit

class MainScreenPageViewController: UIPageViewController, UIPageViewControllerDataSource {
        
    private var controllers = CoreDataManager.shared.fetchControllers() {
        didSet {
            view.setNeedsLayout()
            view.layoutIfNeeded()
            self.pageControl.numberOfPages = controllers?.count ?? 1
            if controllers?.isEmpty == false {
                setAddButtonEnabled()
            }
        }
    }
    
    private func setAddButtonEnabled() {
        addButton.isUserInteractionEnabled = controllers?.isEmpty == false ? false : true
        addButton.alpha = controllers?.isEmpty == false ? 0 : 1
    }
    
    private let searchViewController = SearchCityViewController()
    private let settingsViewController = SettingsViewController(style: .insetGrouped)

    private var fetchedResultsController = CoreDataManager.shared.fetchedResultsController
    
    private lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.setTitle("Добавить город", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.systemGray6, for: .highlighted)
        button.center = view.center
        button.isUserInteractionEnabled = false
        button.alpha = 0
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(
            systemName: "gearshape",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))?
            .withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(settingsDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var locationListButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(
            systemName: "list.bullet",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 24))?
            .withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(locationsDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
      let pager = UIPageControl(frame: .zero)
        pager.numberOfPages = 1
        pager.currentPageIndicatorTintColor = .white
        pager.pageIndicatorTintColor = .lightGray
        pager.numberOfPages = controllers?.count ?? 1
      return pager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.backgroundColor = .white
        self.dataSource = self
        
        setController(0)
        setupLayout()
        setAddButtonEnabled()
        
        searchViewController.didChangeCallback = { [weak self] in
            guard let self = self else { return }
            self.fetchControllers()
            self.setController(0)
            
            if self.controllers?.isEmpty == true {
                self.addButton.isUserInteractionEnabled = true
                self.addButton.alpha = 1
            }
        }
        
        searchViewController.didChooseCityCallback = { [weak self] num in
            guard let self = self else { return }
            self.setController(num)
        }
        
    }
    
    func setController(_ number: Int) {

        if let controller = self.pageViewController(for: number) {
            setViewControllers([controller], direction: .forward, animated: true)
        } else {
            let empty = UIViewController()
            setViewControllers([empty], direction: .forward, animated: true)
        }
        
    }
    
    func setupLayout() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: locationListButton)
        
        view.addSubview(addButton)
        navigationController?.navigationBar.addSubview(pageControl)
        
        let appearanceNavigationBar = UINavigationBarAppearance()
        appearanceNavigationBar.configureWithOpaqueBackground()
        appearanceNavigationBar.backgroundColor = UIColor(named: "main_color")
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearanceNavigationBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        pageControl.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    
    }
    
//    func fetchCities() {
//        self.cities?.removeAll()
//        self.cities = CoreDataManager.shared.fetchCities()
//    }
    
    func fetchControllers() {
        self.controllers?.removeAll()
        self.controllers = CoreDataManager.shared.fetchControllers()
    }
    
    // MARK: OBJC METHODS
    
    @objc
    private func settingsDidTap() {
        let navController = UINavigationController(rootViewController: settingsViewController)
        present(navController, animated: true)
    }
    
    @objc
    private func locationsDidTap() {
        let navController = UINavigationController(rootViewController: searchViewController)
        present(navController, animated: true)
    }

    
    @objc
    private func addButtonAction() {
        let navController = UINavigationController(rootViewController: searchViewController)
        present(navController, animated: true)
    }
    
    // MARK: DELEGATE METHODS
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewController = viewController as? WeatherViewController else { return nil }
        
        let index = viewController.index
        pageControl.currentPage = index

        return index > 0 ? self.pageViewController(for: index - 1) : nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let viewController = viewController as? WeatherViewController, let controllers = self.controllers else { return nil }
        
        let index = viewController.index
        pageControl.currentPage = index
        
        return index < (controllers.count) - 1 ? self.pageViewController(for: index + 1) : nil
    }
    
        
    func pageViewController (for index: Int?) -> UIViewController? {
        
        guard let controllers = controllers, let index = index else { return nil }
        
        if index < 0 || index >= controllers.count { return nil }
                        
        return controllers[index]
        
    }

}
