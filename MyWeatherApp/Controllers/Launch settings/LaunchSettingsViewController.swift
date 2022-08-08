//
//  LaunchSettingsViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 02.08.2022.
//

import UIKit
import SnapKit

class LaunchSettingsViewController: UIViewController {
    
    private lazy var settingsView: LaunchSettingsView = {
       let view = LaunchSettingsView()
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "background_image")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout() {
        
        view.addSubviews(backgroundImageView, settingsView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.center.height.equalToSuperview()
        }

        settingsView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(380)
        }
    }

}
