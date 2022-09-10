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
        
        settingsView.setButton.tapAction = { [weak self] in
            self?.buttonPressed()
        }

        layout()
    }
    
    deinit {
        print ("launchSettings has deinited!")
    }
    
    func buttonPressed() {
        
        let viewController = MainScreenPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func layout() {
        
        view.addSubviews(backgroundImageView, settingsView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.center.height.equalToSuperview()
        }

        settingsView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(450)
        }
    }

}
