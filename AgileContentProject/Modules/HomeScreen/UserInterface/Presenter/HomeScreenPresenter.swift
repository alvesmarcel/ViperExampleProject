// Abstract: Implementation of the HomeScreen presenter, which intermediates the communication between the view (UI) and
// the interactor (application logic)

import UIKit

class HomeScreenPresenter: HomeScreenPresenterInterface {

    weak var view: HomeScreenViewInterface?
    var interactor: HomeScreenInteractorInterface?
    var wireframe: HomeScreenWireframeInterface?
    
    func getGithubUserAction(withUsername username: String) {
        interactor?.getGithubUser(withUsername: username)
    }
    
}

extension HomeScreenPresenter: HomeScreenInteractorDelegate {
    func didRetrieveGithubUser(user: GithubUser?, withError error: HomeScreenError?) {
        if let error = error {
            switch error {
            case .connectionError:
                view?.showErrorMessage(title: "Network Error", message: "A network error has occurred. Check your Internet connection and try again later.")
            case .inexistentUser:
                view?.showErrorMessage(title: "User Not Found", message: "User not found. Please enter another name.")
            case .invalidGithubUsername:
                view?.showErrorMessage(title: "Invalid Github Username", message: "This is an invalid Github username. Please provide a valid username.")
            }
        } else {
            guard let viewNavController = (view as? UIViewController)?.navigationController else {
                print("[HomeScreenPresenter]: Error finding the NavigationController of HomeScreenViewController")
                return
            }
            guard let githubUser = user else {
                print("[HomeScreenPresenter]: Github User should not be nil at this point")
                return
            }
            wireframe?.presentProfileDetail(fromNavigationController: viewNavController, withGithubUser: githubUser)
        }
    }
}
