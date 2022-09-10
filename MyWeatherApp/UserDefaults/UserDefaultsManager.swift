//
//  UserDefaultsManager.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 23.08.2022.
//

import Foundation
import UIKit

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard

    public func isAppAlreadyLaunchedOnce() -> Bool {
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    public func saveSettings(_ boolean: Bool ..., for keys: String ...) {
        guard boolean.count == keys.count else { print(Errors.userDefaults.rawValue); return }
        
        for (index, bool) in boolean.enumerated() {
            defaults.setValue(bool, forKey: keys[index])
            
        }
    }

    
}
