//
//  OnboardingViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 08.08.2022.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    private lazy var onboardingView: OnboardingView = {
       let view = OnboardingView()
        return view
    }()
    
    private lazy var declineButton: UIButton = {
        let button = UIButton()
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.titleLabel?.font = Fonts.onboardDeclineFont
        button.setTitleColor(Colors.mediumTextColor, for: .normal)
        button.setTitleColor(Colors.lightTextColor, for: .highlighted)
        return button
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
        
        view.backgroundColor = .white
        view.addSubviews(backgroundImageView, onboardingView, declineButton)
        
        backgroundImageView.snp.makeConstraints { make in
            make.center.height.equalToSuperview()
        }
        onboardingView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(530)
        }
        
        declineButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(onboardingView.snp.bottom).offset(16)
        }
    }

    
}
