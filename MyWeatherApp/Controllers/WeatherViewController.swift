//
//  WeatherViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 01.08.2022.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
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
    
    @objc
    private func searchButtonPressed() {
        let viewController = SearchCityViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func settingsButtonPressed() {
        let controller = UINavigationController(rootViewController: SettingsViewController(style: .insetGrouped))
        present(controller, animated: true)

    }
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        self.navigationItem.rightBarButtonItem = searchCityBarButtonItem
        self.navigationItem.leftBarButtonItem = settingsBarButtonItem

        
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    
}


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
            height = self.view.safeAreaLayoutGuide.layoutFrame.height * 0.6
        case 1:
            height = self.view.safeAreaLayoutGuide.layoutFrame.height * 0.35
        default:
            break
        }
        return CGSize(width: floor(collectionView.frame.width - 32), height: height)
    }
}
