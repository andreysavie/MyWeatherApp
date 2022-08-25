//
//  Errors.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 23.08.2022.
//

import Foundation

enum Errors: String, Error {
  case layout = "Layout Error"
  case coderInit = "init(coder:) has not been implemented"
  case unwrap = "Can't be unwrapped"
  case retainCycle = "Retain Cycle Error : There is a possibility of memory leaks."
  case json = "Json Parsing Error"
  case callback = " Callback did not capture the context. "
  case userDefaults = "Invalid UserDefaults Data Error"
}

