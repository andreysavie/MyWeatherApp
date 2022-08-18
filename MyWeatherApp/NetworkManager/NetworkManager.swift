//
//  NetworkManager.swift
//  MyWeatherApp
//
//  Created by Андрей Рыбалкин on 09.08.2022.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func didUpdateWeather(_ weatherManager: NetworkManager, weather: WeatherModel, at position: Int)
    func didFailWithError(error: Error)
}

struct NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    // MARK: - FETCHING WEATHER DATA
        
    public func fetchWeather(by city: CityModel, at position: Int = 0) {
        print ("✅\(city)")
        let baseURL = Network.baseURL
        let lat = city.latitude
        let lon = city.longitude
        let apiKey = Network.apiKey
        let units = "metric" // connect UserDefaults
        
        let urlString = "\(baseURL)lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=\(units)&exclude=minutely,alerts"
        
        print(urlString)
        
        performRequest(with: urlString, at: position)
    }
    
    // MARK: - PRIVATE METHODS
    
    fileprivate func performRequest(with urlString: String, at position: Int) {
        let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        if let url = URL(string: encodedURLString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                
                guard error == nil else {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                
                if let weatherData = data {
                    
                    if let weather = self.parseJSON(weatherData) {
                        delegate?.didUpdateWeather(self, weather: weather, at: position)
                    }
                }
            }
            task.resume()
        }
    }
    
    fileprivate func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
        
    fileprivate func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        do {
            let weather = try? newJSONDecoder().decode(WeatherData.self, from: weatherData)
                    
            guard let decodedData = weather else { return nil }
            
            let result = WeatherModel(lat: decodedData.lat,
                                      lon: decodedData.lon,
                                      conditionId: decodedData.current.weather[0].id,
                                      cityName: Misc.defaultSityName,
                                      temperature: decodedData.current.temp,
                                      timezone: decodedData.timezoneOffset,
                                      feelsLike: decodedData.current.feelsLike,
                                      description: decodedData.current.weather[0].weatherDescription,
                                      humidity: decodedData.current.humidity,
                                      uviIndex: decodedData.current.uvi,
                                      wind: decodedData.current.windSpeed,
                                      cloudiness: decodedData.current.clouds,
                                      pressure: decodedData.current.pressure,
                                      visibility: decodedData.current.visibility,
                                      sunrise: decodedData.current.sunrise ?? 0,
                                      sunset: decodedData.current.sunset ?? 0,
                                      daily: decodedData.daily,
                                      hourly: decodedData.hourly,
                                      rain: decodedData.daily[0].rain ?? 0,
                                      dewPoint: decodedData.current.dewPoint)
            return result
        }
    }
}
