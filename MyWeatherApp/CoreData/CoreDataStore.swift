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

    static let shared = CoreDataStore()
    
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
                
       
                

                
//                fetchedForecasts.append(weather)
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
                
                var daily = [DailyEntity]()
                var hourly = [HourlyEntity]()
                
                savingForecast.lat = weather.lat
                savingForecast.lon = weather.lon
                savingForecast.current?.dt = Int32(weather.dt)
                savingForecast.current?.id = Int16(weather.conditionId)
                savingForecast.city?.name = weather.cityName
                savingForecast.current?.temp = weather.temperature
                savingForecast.timezoneOffset = Int32(Int(weather.timezone))
                savingForecast.current?.feelsLike = weather.feelsLike
                savingForecast.current?.descript = weather.description
                savingForecast.current?.humidity = Int16(weather.humidity)
                savingForecast.current?.uvi = weather.uviIndex
                savingForecast.current?.windSpeed = weather.windSpeed
                savingForecast.current?.windGust = weather.windGust
                savingForecast.current?.clouds = Int16(weather.cloudiness)
                savingForecast.current?.pressure = Int16(weather.pressure)
                savingForecast.current?.visibility = Int16(weather.visibility)
                savingForecast.current?.sunrise = Int32(weather.sunrise)
                savingForecast.current?.sunset = Int32(weather.sunset)
                savingForecast.current?.rain = weather.rain
                savingForecast.current?.dewPoint = weather.dewPoint
                savingForecast.current?.icon = weather.icon

                for num in  0...9 {
                    let dailyEntity = DailyEntity(context: self.saveContext)
                    dailyEntity.dt = Int32(weather.daily[num].dt)
                    dailyEntity.icon = weather.daily[num].weather[0].icon
                    dailyEntity.temp?.min = weather.daily[num].temp.min
                    dailyEntity.temp?.max = weather.daily[num].temp.max
                    daily.append(dailyEntity)
                }
                savingForecast.mutableSetValue(forKey: "daily").add(daily)
                
                for num in  0...23 {
                    let hourlyEntity = HourlyEntity(context: self.saveContext)
                    hourlyEntity.dt = Int32(weather.hourly[num].dt)
                    hourlyEntity.icon = weather.hourly[num].weather[0].icon
                    hourlyEntity.temp = weather.hourly[num].temp
                    hourly.append(hourlyEntity)
                }
                savingForecast.mutableSetValue(forKey: "hourly").add(hourly)

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
