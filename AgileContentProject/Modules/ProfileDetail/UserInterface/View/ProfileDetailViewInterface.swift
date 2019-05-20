// Abstract: ProfileDetail view interface, which is used by the presenter to update the view based on the interactor responses

import UIKit

protocol ProfileDetailViewInterface: class {
    func updateUserRepositoriesTableView()
    func updateUserAvatar()
    func showErrorMessage(title: String, message: String)
}
