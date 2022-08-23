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
    
    public func saveSettings(_ boolean: Bool ..., for keys: String ...) {
        guard boolean.count == keys.count else { print(Errors.userDefaults.rawValue); return }
        
        for (index, bool) in boolean.enumerated() {
            UserDefaults.standard.setValue(bool, forKey: keys[index])
            
        }
    }

    
}
