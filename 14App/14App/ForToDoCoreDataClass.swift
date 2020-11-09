import Foundation
import CoreData

class ForToDoCoreData: ToDoProtocol {

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "_4App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    var context = NSManagedObjectContext()
    func z(context: NSManagedObjectContext) -> NSManagedObjectContext{
        return persistentContainer.viewContext
    }

    let fetchRequest: NSFetchRequest<TaskCoreData> = TaskCoreData.fetchRequest()

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
              context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func countAll() -> Int {
        context = z(context: context)
        let all = try! context.fetch(fetchRequest)
        return all.count
    }

    func add(vars: Vars) {
        context = z(context: context)
        let task = TaskCoreData(context: context)
        task.task = vars.text
        saveContext()
    }

    func delete(vars: Vars) {
        context = z(context: context)
        let all = try! context.fetch(fetchRequest)
        context.delete(all[vars.indexElement])
        saveContext()
    }

    func remove() {
        context = z(context: context)
        let all = try! context.fetch(fetchRequest)
        for i in all {
            context.delete(i)
        }
        saveContext()
    }

    func listAll() -> [String] {
        context = z(context: context)
        var z: [String] = []
        let all = try! context.fetch(fetchRequest)
        for i in all {
            z.append(i.task ?? "")
        }
        return z
    }

}
