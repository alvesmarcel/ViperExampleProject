import UIKit

class ProfileDetailViewController: UIViewController {
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    let tableViewCellIdentifier = "RepositoryCell"
    
    var presenter: ProfileDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        repositoriesTableView.dataSource = self
    }
    
}

extension ProfileDetailViewController: ProfileDetailViewInterface {
    
    func updateUserRepositoriesTableView() {
        DispatchQueue.main.async {
            self.repositoriesTableView.reloadData()
        }
    }
    
    func updateUserAvatar() {
        DispatchQueue.main.async {
            // TODO: Set avatar image
        }
    }
    
    func showErrorMessage(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
}
