// Abstract: Implementation of the ProfileDetail presenter, which intermediates the communication between the view (UI) and
// the interactor (application logic)

import UIKit

class ProfileDetailPresenter: ProfileDetailPresenterInterface {
    
    weak var view: ProfileDetailViewInterface?
    var interactor: ProfileDetailInteractorInterface?
    
    var githubUser: GithubUser?
    var userRepositories: [GithubRepository]?
    var userAvatar: UIImage?
    
    func viewDidLoad() {
        guard let user = githubUser else {
            print("[ProfileDetailPresenter]: githubUser should be set!")
            return
        }
        interactor?.getGithubUserRepositories(githubUser: user)
        interactor?.getUserProfileImage(githubUser: user)
    }
    
}

extension ProfileDetailPresenter: ProfileDetailInteractorDelegate {
    
    func didRetrieveGithubUserRepositories(_ repositories: [GithubRepository]) {
        userRepositories = repositories
        view?.updateUserRepositoriesTableView()
    }
    
    func onError(_ error: Error) {
        view?.showErrorMessage(title: "Network Error", message: "A network error has occurred. Check your Internet connection and try again later.")
    }
    
    func didRetrieveGithubUserAvatar(imageData: Data) {
        userAvatar = UIImage(data: imageData)
        view?.updateUserAvatar()
    }
    
}
