//
//  CoreDataManager.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 23.08.2022.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {
        
    // MARK: PROPERTIES
    

    static let shared = CoreDataManager()
        
    var fetchedResultsController: NSFetchedResultsController<CityModelEntity> {

        let fetchRequest: NSFetchRequest<CityModelEntity> = CityModelEntity.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.context, sectionNameKeyPath: nil, cacheName: "Master")

        do {
            try fetchedResultsController.performFetch()
        } catch let error{
            print(error.localizedDescription)
        }
        return fetchedResultsController
    }
    
    
        
    // MARK: METHODS
    
   public func saveCity(city: CityModel) {

        guard let savedCities = fetchedResultsController.fetchedObjects else { return }
        
       if savedCities.contains(where: { $0.name == city.name }) {
            print("The city is already in the cities list")
            return
        } else {
            
            let context = self.fetchedResultsController.managedObjectContext
                let newCity = CityModelEntity(context: context)
            newCity.name = city.name
            newCity.lat = city.latitude
            newCity.lon = city.longitude
            
            CoreDataStack.shared.saveContext()
        }
    }
    
    public func fetchCities() -> [CityModel]? {
        let fetchRequest = CityModelEntity.fetchRequest()
        var fetchedCities = [CityModel]()
        var cities = [CityModelEntity]()
        do {
            cities = try CoreDataStack.shared.context.fetch(fetchRequest)
            for fetchedCity in cities {
                
                let city = CityModel(
                    name: fetchedCity.name ?? "unknown",
                    longitude: fetchedCity.lon,
                    latitude: fetchedCity.lat
                )
                
                fetchedCities.append(city)
            }
        } catch let error {
            print(error)
        }
        return fetchedCities
    }
    
    public func fetchControllers () -> [UIViewController]? {
//        let cities = self.fetchCities()
        guard let cities = fetchedResultsController.fetchedObjects else { return nil }
        
        var controllers = [UIViewController]()
        
//        guard let cities = cities else { return nil }
        
        for (index, value) in cities.enumerated() {
//            let city = CityModel(name: value.name ?? "Unknown", longitude: value.lon, latitude: value.lat)
            let viewController = WeatherViewController(city: value, index: index)
            controllers.append(viewController)
        }
        return controllers
    }
}

