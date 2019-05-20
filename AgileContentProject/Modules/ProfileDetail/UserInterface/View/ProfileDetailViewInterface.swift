import UIKit

protocol ProfileDetailViewInterface: class {
    func updateUserRepositoriesTableView()
    func updateUserAvatar()
    func showErrorMessage(title: String, message: String)
}
