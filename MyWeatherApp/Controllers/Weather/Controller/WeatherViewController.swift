//
//  WeatherViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 01.08.2022.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    let city: String
    var index: Int
//    
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
    
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        //        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 8,
            left: 0,
            bottom: 8,
            right: 0)
        return layout
    }()
    
    // MARK: INITS
    
    init (city: String, index: Int) {
        self.city = city
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = city
        
        collectionView.register(
            CurrentWeatherCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.identifier
        )
        
        collectionView.register(
            DailyCollectionViewCell.self,
            forCellWithReuseIdentifier: DailyCollectionViewCell.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
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


extension WeatherViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.identifier, for: indexPath) as? CurrentWeatherCollectionViewCell else { return UICollectionViewCell() }
            
            cell.detailsButtonAction = { [weak self] in
                let viewController = DetailsWeatherViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCollectionViewCell.identifier, for: indexPath) as? DailyCollectionViewCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegate {
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        
        switch indexPath.section {
        case 0:
            height = self.view.safeAreaLayoutGuide.layoutFrame.height * 0.55
        case 1:
            height = self.view.safeAreaLayoutGuide.layoutFrame.height * 0.40
        default:
            break
        }
        return CGSize(width: floor(collectionView.frame.width - 32), height: height)
    }
}
