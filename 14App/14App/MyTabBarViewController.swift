import UIKit

class MyTabBarViewController: UITabBarController {

    override func viewDidLoad() {

        super.viewDidLoad()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let personViewController = storyBoard.instantiateViewController(withIdentifier: "Default") as? PersonController
        let toDoViewController = storyBoard.instantiateViewController(withIdentifier: "Default1") as? ToDoViewController
        let toDoViewController1 = storyBoard.instantiateViewController(withIdentifier: "Default1") as? ToDoViewController
        let weatherViewController = storyBoard.instantiateViewController(withIdentifier: "Default2") as? WeatherViewController
        if let person = personViewController, let toDoRealm = toDoViewController,
            let toDoCoreData = toDoViewController1, let weather = weatherViewController {
            toDoRealm.forWhat = ForToDoRealm()
            toDoCoreData.forWhat = ForToDoCoreData()

            let icon = UIImage(systemName: "circle")
            person.tabBarItem = UITabBarItem(title: "Person", image: icon, selectedImage: icon)
            toDoRealm.tabBarItem = UITabBarItem(title: "Realm", image: icon, selectedImage: icon)
            toDoCoreData.tabBarItem = UITabBarItem(title: "CoreData", image: icon, selectedImage: icon)
            weather.tabBarItem = UITabBarItem(title: "Weather", image: icon, selectedImage: icon)

            viewControllers = [person, toDoRealm, toDoCoreData, weather]
        }

    }
}
