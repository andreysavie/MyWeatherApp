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
    
//    private lazy var titleLabel = getLabel(
//        text: "􀉉 ПРОГНОЗ НА 10 ДНЕЙ",
//        font: Fonts.tenDayTitleFont,
//        color: Colors.mainTextColor
//    )
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        return tableView
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
        
        setShadow(contentView)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "􀉉 ПРОГНОЗ НА 10 ДНЕЙ"
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


