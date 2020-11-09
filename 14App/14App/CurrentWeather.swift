import Foundation

struct CurrMain: Codable {
    var temp: Double
    var feelsLike: Double
    var pressure: Int
    var humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
}

struct CurrWeatherDescription: Codable {
    var main: String
    var description: String
}

struct CurrentWeather: Codable {
    var main: CurrMain
    var weather: [CurrWeatherDescription]
}
