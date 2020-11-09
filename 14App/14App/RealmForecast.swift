import Foundation
import RealmSwift

class RealmForecast: Object {
    @objc dynamic var tempDay = 0.0
    @objc dynamic var tempNight = 0.0
    @objc dynamic var weather = "LOADING.."
}
