// Abstract: Implementation of HomeScreen interactor, which deals the HomeScreen application logic

import Foundation

class HomeScreenInteractor: HomeScreenInteractorInterface {
    
    var githubAPI: GithubAPI?
    weak var presenter: HomeScreenInteractorDelegate?
    
    func getGithubUser(withUsername username: String) {
        if isGithubUsernameValid(username: username) {
            githubAPI?.getUser(withUsername: username) { (githubUser, error) in
                if let user = githubUser {
                    self.presenter?.didRetrieveGithubUser(user)
                } else {
                    guard let unwrappedError = error else {
                        print("[HomeScreenInteractor]: Error should not be nil if user is nil")
                        return
                    }
                    guard let homeScreenError = HomeScreenError(error: unwrappedError) else {
                        print("[HomeScreenInteractor]: Unknown error created nil HomeScreenError")
                        return
                    }
                    self.presenter?.onError(homeScreenError)
                }
            }
        } else {
            presenter?.onError(.invalidGithubUsername) // We don't make requests for invalid user
        }
    }
    
}

// MARK: Private functions

extension HomeScreenInteractor {
    
    private func isGithubUsernameValid(username: String) -> Bool {
        // Valid Github username: (source: https://github.com/shinnn/github-username-regex)
        // - Contains alphanumeric characters or hyphens.
        // - Cannot have multiple consecutive hyphens.
        // - Cannot begin or end with a hyphen.
        // - Maximum of 39 characters.
        return username.range(of: #"^[a-z\d](?:[a-z\d]|-(?=[a-z\d])){0,38}$"#, options: .regularExpression) != nil
    }
    
}
