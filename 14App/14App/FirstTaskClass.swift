import Foundation

class Person {
    static let shared = Person()
    private let nameKey = "Person.nameKey"
    private let surnameKey = "Person.surnameKey"
    
    var name: String? {
        set { UserDefaults.standard.set(newValue, forKey: nameKey) }
        get { return UserDefaults.standard.string(forKey: nameKey) }
    }
    
    var surname: String? {
        set { UserDefaults.standard.set(newValue, forKey: surnameKey) }
        get { return UserDefaults.standard.string(forKey: surnameKey) }
    }
}
