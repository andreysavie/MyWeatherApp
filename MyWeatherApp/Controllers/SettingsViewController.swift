//
//  SettingsViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 06.08.2022.
//

import UIKit
import SnapKit

class SettingsViewController: UITableViewController {
    
    private lazy var settingsTableView: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Настройки"
        navigationItem.titleView?.tintColor = Colors.darkTextColor
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Colors.settingsBackgroundColor
        
    }
    
    func setupLayout() {
        view.addSubview(settingsTableView)
        
        settingsTableView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

