import Foundation

class HomeScreenInteractor: HomeScreenInteractorInterface {
    
    var githubAPI: GithubAPI?
    weak var presenter: HomeScreenInteractorDelegate?
    
    func getGithubUser(withUsername username: String) {
        if isGithubUsernameValid(username: username) {
            githubAPI?.getUser(withUsername: username) { (githubUser, error) in
                self.presenter?.didRetrieveGithubUser(user: githubUser, withError: HomeScreenError(error: error))
            }
        } else {
            presenter?.didRetrieveGithubUser(user: nil, withError: .invalidGithubUsername)
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
