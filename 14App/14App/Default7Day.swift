import Foundation

struct Forecast: Codable {
    var daily: [Day]
}
struct Weather: Codable {
    var main: String
}

struct Temp: Codable {
    var day: Double
    var night: Double
}

struct Day: Codable {
    var dt: Int
    var weather: [Weather]
    var temp: Temp
}
