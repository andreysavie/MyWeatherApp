//
//  DailyForecastCollectionViewCell.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 04.08.2022.
//

import UIKit
import SnapKit

class DailyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DailyForecastCollectionViewCell"
    
    var currentWeather: WeatherModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
        table.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        table.sectionHeaderHeight = UITableView.automaticDimension
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        
        tableView.dataSource = self
//        tableView.delegate = self

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLayout() {
        
        getShadow(contentView)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    func configureOfCell(weather: WeatherModel?) {
        guard let wthr = weather else { return }
        currentWeather = wthr
    }

}

extension DailyCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWeather?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        cell.configureOfCell(currentWeather, at: indexPath.row)
        return cell
    }

}
