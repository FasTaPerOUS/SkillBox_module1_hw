import Foundation

protocol ToDoProtocol {
    func countAll() -> Int
    func add(vars: Vars)
    func delete(vars: Vars)
    func remove()
    func listAll() -> [String]
}
