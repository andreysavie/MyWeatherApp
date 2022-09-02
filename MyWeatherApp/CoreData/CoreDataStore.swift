//
//  CoreDataStore.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 02.09.2022.
//

import Foundation
import CoreData

final class CoreDataStore {
        
    // MARK: PROPERTIES

    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    private let fetchRequest: NSFetchRequest<WeatherEntity>

    private lazy var context = persistentContainer.viewContext
    
    private lazy var saveContext: NSManagedObjectContext = {
        let saveContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        saveContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        saveContext.mergePolicy = NSOverwriteMergePolicy
        return saveContext
    }()
    
    // MARK: INITS

    private init() {
        let container = NSPersistentContainer(name: "MyWeatherApp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        self.persistentContainer = container
        self.fetchRequest = WeatherEntity.fetchRequest()

    }
    
    // MARK: METHODS

    func fetchWeather() -> [WeatherModel] {
        
        var fetchedForecasts = [WeatherModel]()
        var weatherEntities = [WeatherEntity]()
        
        do {
            weatherEntities = try context.fetch(fetchRequest)
            for entity in weatherEntities {
                
                let city = CityModel(
                    name: entity.city?.name ?? "",
                    longitude: entity.city?.lon ?? 0,
                    latitude: entity.city?.lat ?? 0
                )
                
                let weather = WeatherModel(
                    lat: entity.lat,
                    lon: entity.lon,
                    dt: Int(entity.current.dt),
                    conditionId: Int(entity.id),
                    cityName: entity.city?.name,
                    temperature: entity.current?.temp,
                    timezone: Int(entity.timezoneOffset),
                    feelsLike: entity.current?.feelsLike,
                    description: entity.weatherDescription,
                    humidity: entity.current?.humidity,
                    uviIndex: entity.current?.uvi,
                    windSpeed: entity.current?.windSpeed,
                    windGust: entity.current?.windGust,
                    cloudiness: entity.current?.clouds,
                    pressure: entity.current?.pressure,
                    visibility: entity.current?.visibility,
                    sunrise: entity.current?.sunrise,
                    sunset: entity.current?.sunset,
                    daily: entity.daily,
                    hourly: entity.hourly,
                    rain: entity.current?.rain,
                    dewPoint: entity.current?.dewPoint,
                    icon: entity.icon)
                
                fetchedForecasts.append(weather)
            }
        } catch let error {
            print(error)
        }
        fetchRequest.predicate = nil
        return fetchedForecasts
    }
    
//    func fetchFiltredFavourites(_ author: String) -> [Post] {
//            let predicate = NSPredicate(format: "author = %@", author)
//        fetchRequest.predicate = predicate
//        return fetchFavourites()
//    }
    
    func saveWeather (_ weather: WeatherModel) {

        let fetchedForecasts = fetchWeather()
        if fetchedForecasts.contains(where: { $0.cityName == weather.cityName }) {
            print("The forecast is already saved!") // edit!
            return
        } else {
            
            saveContext.perform {
                let savingForecast = WeatherEntity(context: self.saveContext)
              
                savingForecast.icon = weather.icon // и ещё много много ВСЕГО!
                
                
                do {
                    try self.saveContext.save()
                    print("💾 Saved: \(weather.cityName)")
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteForecast (_ weather: WeatherModel) {
        var forecasts = [WeatherEntity]()
        
        do {
            forecasts = try saveContext.fetch(fetchRequest)
                    
            saveContext.perform {
                        for forecast in forecasts {
                            if forecast.city?.name == weather.cityName {
                                
                        self.saveContext.delete(forecast)

                        do {
                            try self.saveContext.save()
                            print("Deleted: \(weather.cityName)")
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    //MARK: CoreData: Remove all data
    
    public func removeFromCoreData() {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WeatherEntity")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
    }
}
// MARK: SUBMETHODS

extension CoreDataManager {
    
    func printThread() {
        if Thread.isMainThread {
            print ("✅ on main thread")
        } else {
            print ("⛔️ off main thread")
        }
    }
}
