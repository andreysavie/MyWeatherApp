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
    
    private lazy var icon = getAppIcon(.calendar, 18)
    
    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(
            numberOfLines: 1,
            text: "Прогноз на 10 дней",
            font: Fonts.tenDayTitleFont,
            textColor: Colors.mediumTextColor
        )
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
        table.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        table.showsVerticalScrollIndicator = false
        table.automaticallyAdjustsScrollIndicatorInsets = false
        table.contentInset = UIEdgeInsets.zero

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
        contentView.addSubviews(icon, titleLabel, tableView)

        icon.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
            make.width.height.equalTo(18)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(8)
            make.top.trailing.equalToSuperview().inset(16  )
            
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
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
