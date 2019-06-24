// Abstract: ProfileDetail presenter interface, which is used by the view to inform of the user initiated events
// This presenter doesn't need a reference to the wireframe because it doesn't present any new views

import UIKit

protocol ProfileDetailPresenterInterface: class {
    var view: ProfileDetailViewInterface? { get set }
    var interactor: ProfileDetailInteractorInterface? { get set }
    var githubUser: GithubUser? { get set }
    var userRepositories: [GithubRepository]? { get }
    var userAvatar: UIImage? { get }
    func viewDidLoad()
}
