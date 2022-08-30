//
//  SettingsViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 06.08.2022.
//

import UIKit
import SnapKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Настройки"
        navigationItem.titleView?.tintColor = Colors.darkTextColor
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Colors.settingsBackgroundColor
        
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

        setupLayout()
        
    }
    
    private lazy var saveButton: CustomButton = {
        let button = CustomButton(normalColor: Colors.darkTextColor, highlightedColor: Colors.mediumTextColor, title: "Сохранить", font: Fonts.settingsLabelFont)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.backgroundColor = Colors.blueColor
        button.layer.cornerRadius = 16
        return button
    }()
    
    func setupLayout() {
        
        tableView.backgroundColor = Colors.settingsBackgroundColor
        tableView.sectionIndexBackgroundColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
    }
    
    func loadSettingsValues() {
        
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapAction() {
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                        
        switch indexPath.section {
        case 0, 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.configure(indexPath.section, for: indexPath.row)
            return cell

        case 2:
            let cell = UITableViewCell (style: .default, reuseIdentifier: nil)
            var content: UIListContentConfiguration = cell.defaultContentConfiguration()
            content.text = "Закрыть"
            content.textProperties.alignment = .center
            cell.contentConfiguration = content
            cell.backgroundColor = Colors.blueColor
            cell.tintColor = .white
            cell.selectionStyle = .gray
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Приложение"
        case 1: return "Прогноз"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            dismiss(animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


