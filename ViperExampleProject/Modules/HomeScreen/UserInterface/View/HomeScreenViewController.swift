// Abstract: Implementation of HomeScreen view, which listens to the user initiated events and informs them to the presenter

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    var presenter: HomeScreenPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        usernameTextField.delegate = self
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        if let text = usernameTextField.text {
            presenter?.getGithubUserAction(withUsername: text)
        }
    }
    
}

extension HomeScreenViewController: HomeScreenViewInterface {
    
    func showErrorMessage(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
