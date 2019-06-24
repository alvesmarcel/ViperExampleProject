// Abstract: HomeScreen interactor interface, which is used by the HomeScreen presenter to send requests to the interactor

protocol HomeScreenInteractorInterface: class {
    var githubAPI: GithubAPI? { get set }
    var presenter: HomeScreenInteractorDelegate? { get set }
    func getGithubUser(withUsername username: String)
}
