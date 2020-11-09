import Foundation
import RealmSwift

class RealmCurrentWeather: Object {
    @objc dynamic var temp = "LOADING.."
    @objc dynamic var main = "LOADING.."
    @objc dynamic var feelsTemp = "LOADING.."
    @objc dynamic var weatherDescription = "LOADING.."
    @objc dynamic var humidity = "LOADING.."
    @objc dynamic var pressure = "LOADING.."
}
