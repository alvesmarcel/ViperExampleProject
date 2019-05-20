import UIKit

class ProfileDetailPresenter: ProfileDetailPresenterInterface {
    
    weak var view: ProfileDetailViewInterface?
    var interactor: ProfileDetailInteractorInterface?
    var wireframe: ProfileDetailWireframeInterface?
    
    var githubUser: GithubUser?
    var userRepositories: [GithubRepository]?
    var userAvatar: UIImage?
    
    func viewDidLoad() {
        guard let user = githubUser else {
            print("[ProfileDetailPresenter]: githubUser should be set!")
            return
        }
        interactor?.getGithubUserRepositories(githubUser: user)
    }
    
}

extension ProfileDetailPresenter: ProfileDetailInteractorDelegate {
    
    func didRetrieveGithubUserRepositories(repositories: [GithubRepository]?, withError error: Error?) {
        if let repos = repositories {
            userRepositories = repos
            view?.updateUserRepositoriesTableView()
        } else {
            view?.showErrorMessage(title: "Network Error", message: "A network error has occurred. Check your Internet connection and try again later.")
        }
    }
    
    func didRetrieveGithubUserAvatar(imageData: Data) {
        // TODO
    }
    
}