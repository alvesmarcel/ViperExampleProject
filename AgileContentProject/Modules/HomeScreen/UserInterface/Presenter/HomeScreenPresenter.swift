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
            // TODO: Implement transition to the next screen
        }
    }
}
