import UIKit

class PersonController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        surnameTextField.delegate = self
        nameLabel.text = Person.shared.name
        surnameLabel.text = Person.shared.surname
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func nameSetter() {
        Person.shared.name = nameTextField.text
    }
    
    @IBAction func surnameSetter() {
        Person.shared.surname = surnameTextField.text
    }
    
}

