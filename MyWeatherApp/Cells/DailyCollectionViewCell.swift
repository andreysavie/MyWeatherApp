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
    
    private lazy var titleLabel: CustomLabel = {
        let label = CustomLabel(
            text: "Прогноз на 10 дней".uppercased(),
            font: Fonts.tenDayTitleFont,
            textColor: Colors.mediumTextColor
        )
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .clear
        table.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        table.sectionHeaderHeight = UITableView.automaticDimension
        table.estimatedSectionHeaderHeight = 50
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
        let calendarIcon = getAppIcon(.calendar, 15)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.addSubviews(calendarIcon, titleLabel, tableView)
        
        calendarIcon.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
        }

        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(calendarIcon.snp.trailing).offset(4)
            make.top.trailing.equalToSuperview().inset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension DailyCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        return cell
    }

}

//extension DailyForecastCollectionViewCell: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//    {
//        let header = view as! UITableViewHeaderFooterView
//        header.textLabel?.font = Fonts.tenDayTitleFont
//        header.textLabel?.textColor = Colors.darkTextColor
//    }
//}


