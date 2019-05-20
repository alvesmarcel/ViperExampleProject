import UIKit

protocol ProfileDetailPresenterInterface: class {
    var view: ProfileDetailViewInterface? { get set }
    var interactor: ProfileDetailInteractorInterface? { get set }
    var wireframe: ProfileDetailWireframeInterface? { get set }
    var githubUser: GithubUser? { get set }
    var userRepositories: [GithubRepository]? { get }
    var userAvatar: UIImage? { get }
    func viewDidLoad()
}
