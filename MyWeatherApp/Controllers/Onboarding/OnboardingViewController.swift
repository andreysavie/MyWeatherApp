//
//  OnboardingViewController.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 08.08.2022.
//

import UIKit
import SnapKit
import MapKit

class OnboardingViewController: UIViewController {
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()

    private lazy var onboardingView: OnboardingView = {
       let view = OnboardingView()
        return view
    }()

    private lazy var declineButton: CustomButton = {
        let button = CustomButton(
            normalColor: Colors.mediumTextColor,
            highlightedColor: Colors.lightTextColor,
            title: "Нет, я буду добавлять локации".uppercased(),
            font: Fonts.onboardDeclineFont
        )
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
        
        setupLayout()
        
        locationManager.delegate = self

        
        onboardingView.confimButton.tapAction = { [weak self] in
            self?.buttonPressed()
        }
        
        declineButton.tapAction = { [weak self] in
            self?.buttonPressed()
        }
        
    }
    
    deinit {
        print ("Onboarding has deinited!")
    }
    
    func buttonPressed() {
        checkAuthorizationStatus()
        let viewController = LaunchSettingsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func checkAuthorizationStatus() {
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            locationManager.requestLocation()
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            break
            
        @unknown default:
            break
        }
    }
    
    func setupLayout() {
        
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

extension OnboardingViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("⛔️ \(error.localizedDescription)")
    }
        
}
