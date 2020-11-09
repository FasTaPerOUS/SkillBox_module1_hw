import UIKit
import RealmSwift
import CoreData

class ToDoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var taskTableView: UITableView!
    
    var forWhat: ToDoProtocol?
    var vars = Vars()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addTask() {
        guard let text = addTaskTextField.text else { return }
        if text == "" { return }
        self.view.endEditing(true)
        vars.text = text
        forWhat?.add(vars: vars)
        addTaskTextField.text = ""
        taskTableView.reloadData()
    }
    
    @IBAction func deleteAllTasks() {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete all tasks?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action: UIAlertAction!) -> Void in
            self.forWhat?.remove()
            self.taskTableView.reloadData()
         }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction!) -> Void in }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forWhat?.countAll() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let all = forWhat?.listAll()
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task") as! TaskTableViewCell
        cell.numOfTaskLabel.text = String(indexPath.row + 1) + "."
        cell.taskLabel.text = all?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vars.indexElement = indexPath.row
            forWhat?.delete(vars: vars)
            tableView.deleteRows(at: [indexPath], with: .fade)
            taskTableView.reloadData()
        }
    }
}
