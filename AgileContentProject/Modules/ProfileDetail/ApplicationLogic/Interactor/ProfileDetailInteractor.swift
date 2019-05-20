// Abstract: Implementation of ProfileDetail interactor, which deals the ProfileDetail application logic

class ProfileDetailInteractor: ProfileDetailInteractorInterface {
    
    var githubAPI: GithubAPI?
    var networkService: NetworkService?
    weak var presenter: ProfileDetailInteractorDelegate?
    
    func getGithubUserRepositories(githubUser: GithubUser) {
        githubAPI?.getUserRepositories(user: githubUser) { (repositories, error) in
            if let repos = repositories {
                self.presenter?.didRetrieveGithubUserRepositories(repos)
            } else {
                guard let networkError = error else {
                    print("[ProfileDetailInteractor]: Network error should not be nil if repositories array is nil")
                    return
                }
                self.presenter?.onError(networkError) // Only network errors can happen in this module
            }
        }
    }
    
    func getUserProfileImage(githubUser: GithubUser) {
        networkService?.requestDataFromURL(url: githubUser.avatarURL) { (data, error) in
            // No need to inform the user about a network error just because the avatar wasn't downloaded
            if let imageData = data {
                self.presenter?.didRetrieveGithubUserAvatar(imageData: imageData)
            }
        }
    }
    
}
