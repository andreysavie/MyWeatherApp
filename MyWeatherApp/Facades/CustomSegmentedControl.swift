//
//  CustomSegmentedControl.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 08.08.2022.
//

import Foundation
import UIKit

final class CustomSegmentedControl: UISegmentedControl {
    
    var itemsArray = [String]()
    
    let setting: Settings?
        
    init? (setting: Settings?) {
        self.setting = setting
        
        super.init(frame: .zero)
        
        switch setting {
        case .notifications:
            itemsArray = ["On", "Off"]
        case .time:
            itemsArray = ["12", "24"]
        case .date:
            return nil
        case .temp:
            itemsArray = ["C", "F"]
        case .speed:
            itemsArray = ["Mi", "Km"]
        case .visibility:
            itemsArray = ["Mi", "Km"]
        case .none:
            return nil
        }
        self.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
        self.selectedSegmentIndex = 0
        self.backgroundColor = Colors.segmentedControlBackColor
        self.selectedSegmentTintColor = .white
        self.setTitleTextAttributes(Attributes.settingsSemgentedControlAttributes, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override init(items: [Any]?) {
//        super.init(items: itemsArray)
//    }
    
}

func getSegmentedControl(_ setting: Settings?) -> UISegmentedControl? {
    
    var items: [String]
    
    switch setting {
    case .notifications:
        items = ["On", "Off"]
    case .time:
        items = ["12", "24"]
    case .date:
        return nil
    case .temp:
        items = ["C", "F"]
    case .speed:
        items = ["Mi", "Km"]
    case .visibility:
        items = ["Mi", "Km"]
    case .none:
        return nil
    }


    
    let control = UISegmentedControl(items: items)
    control.frame = CGRect(x: 0, y: 0, width: 80, height: 32)
    control.selectedSegmentIndex = 0
    control.backgroundColor = Colors.segmentedControlBackColor
    control.selectedSegmentTintColor = .white
    control.setTitleTextAttributes(Attributes.settingsSemgentedControlAttributes, for: .normal)
    return control
}
