import UIKit

class HomeScreenViewController: UIViewController {
    

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        // TODO: Implement search button action
    }
}

extension HomeScreenViewController: HomeScreenViewInterface {
    func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
