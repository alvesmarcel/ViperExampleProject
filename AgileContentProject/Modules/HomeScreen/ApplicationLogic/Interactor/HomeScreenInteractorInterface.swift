protocol HomeScreenInteractorInterface: class {
    var githubAPI: GithubAPI? { get set }
    var presenter: HomeScreenInteractorDelegate? { get set }
    func getGithubUser(withUsername username: String)
}
