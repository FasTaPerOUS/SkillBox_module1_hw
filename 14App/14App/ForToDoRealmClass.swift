import Foundation
import RealmSwift

class ForToDoRealm: ToDoProtocol {
    let realm = try! Realm()
    
    func countAll() -> Int {
        let all = self.realm.objects(ToDoRealm.self)
        return all.count
    }
    
    func add(vars: Vars) {
        let object = ToDoRealm()
        object.task = vars.text
        try! realm.write {
            realm.add(object)
        }
    }
    
    func delete(vars: Vars) {
        let all = realm.objects(ToDoRealm.self)
        try! realm.write {
            realm.delete(all[vars.indexElement])
        }
    }
    
    func remove() {
        let all = realm.objects(ToDoRealm.self)
        if all.count == 0 { return }
        try! self.realm.write {
            self.realm.delete(all)
        }
    }
    
    func listAll() -> [String] {
        let all = self.realm.objects(ToDoRealm.self)
        var z: [String] = []
        for a in all {
            z.append(a.task)
        }
        return z
    }
}
