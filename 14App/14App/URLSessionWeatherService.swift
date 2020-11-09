import UIKit
import Foundation

class URLSessionWeatherService: WeatherService {
    var arrForecast: Forecast?
    
    func loadCurrentWeather(completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=moscow&appid=f09cf89f826e05bcdb8f30d73fb9bf5e")!
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                completion(.success(try decoder.decode(CurrentWeather.self, from: data)))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    func loadForecast(completion: @escaping (Result<Forecast, Error>) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55&lon=37&%20exclude=daily&appid=b74840490fd80268b4f1e3a2f4d0b1bf")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                completion(.success(try decoder.decode(Forecast.self, from: data)))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
}
