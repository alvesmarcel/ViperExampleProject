class ProfileDetailInteractor: ProfileDetailInteractorInterface {
    
    var githubAPI: GithubAPI?
    var networkService: NetworkService?
    weak var presenter: ProfileDetailInteractorDelegate?
    
    func getGithubUserRepositories(githubUser: GithubUser) {
        githubAPI?.getUserRepositories(user: githubUser) { (repositories, error) in
            self.presenter?.didRetrieveGithubUserRepositories(repositories: repositories, withError: error)
        }
    }
    
    func getUserProfileImage(githubUser: GithubUser) {
        networkService?.requestDataFromURL(url: githubUser.avatarURL) { (data, error) in
            // TODO
        }
    }
    
}
