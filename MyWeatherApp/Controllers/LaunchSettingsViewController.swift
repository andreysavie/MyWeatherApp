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
    
    private lazy var gradient = getGradient(start: CGPoint(x: 0.5, y: 0), end: CGPoint(x: 0.5, y: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        view.addSubview(settingsView)
        layout()
    }
    
    func layout() {
        settingsView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(380)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
