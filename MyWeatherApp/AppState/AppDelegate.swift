//
//  AppDelegate.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 01.08.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        let viewController = MainScreenPageViewController(transitionStyle: .scroll , navigationOrientation: .horizontal)
//        let navigationController = UINavigationController(rootViewController: viewController)
        
        let viewController = OnboardingViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
