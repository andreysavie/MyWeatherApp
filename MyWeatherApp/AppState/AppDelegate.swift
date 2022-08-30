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
        
//        let city = CityModel(name: "Мухосранск", longitude: 39.71, latitude: 47.24)
//        CoreDataManager.shared.saveCity(city: city)
        
//        let city = CityModel(name: "", latitude: 47.24, longitude: 39.71)
//        let manager = NetworkManager()
//        manager.fetchWeather(by: city)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let viewController = MainScreenPageViewController(transitionStyle: .scroll , navigationOrientation: .horizontal)
        let navigationController = UINavigationController(rootViewController: viewController)
        
//        window?.rootViewController = LaunchSettingsViewController()
        
//        let viewController = WeatherViewController()

//        let viewController = OnboardingViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)

//        let viewController = LaunchSettingsViewController()
//        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController

//        window?.rootViewController = navigationController


        window?.makeKeyAndVisible()
        
        return true
    }


    // MARK: - Core Data stack

//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "MyWeatherApp")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()

    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//}

}
