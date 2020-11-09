import UIKit
import Foundation
import RealmSwift

protocol WeatherService {
    var arrForecast: Forecast? { get set }
    
    func loadCurrentWeather(completion: @escaping (Result<CurrentWeather, Error>) -> Void)
    func loadForecast(completion: @escaping (Result<Forecast, Error>) -> Void)
}

