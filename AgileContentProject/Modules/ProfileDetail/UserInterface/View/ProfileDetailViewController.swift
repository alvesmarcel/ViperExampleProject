// Abstract: Implementation of ProfileDetail view, which listens to the user initiated events and informs them to the presenter

import UIKit

class ProfileDetailViewController: UIViewController {
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    let tableViewCellIdentifier = "RepositoryCell"
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var presenter: ProfileDetailPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        repositoriesTableView.dataSource = self
        navigationController?.navigationBar.shadowImage = UIImage() // Removes separator line from navigation bar
        configureInitialUI()
    }
    
    func configureInitialUI() {
        userNameLabel.text = presenter?.githubUser?.name
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.size.width / 2
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
            self.userAvatarImageView.image = self.presenter?.userAvatar
            self.userNameLabel.text = self.presenter?.githubUser?.name
            
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
