//
//  CoreDataManager.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 23.08.2022.
//

import Foundation
import CoreData

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
    
   public func saveCity (city: CityModel) {

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
}

