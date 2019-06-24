// Abstract: ProfileDetail interactor interface, which is used by the ProfileDetail presenter to send requests to the interactor

protocol ProfileDetailInteractorInterface: class {
    var githubAPI: GithubAPI? { get set }
    var networkService: NetworkService? { get set }
    var presenter: ProfileDetailInteractorDelegate? { get set }
    func getGithubUserRepositories(githubUser: GithubUser)
    func getUserProfileImage(githubUser: GithubUser)
}
