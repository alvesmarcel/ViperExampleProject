protocol HomeScreenInteractorDelegate: class {
    func didRetrieveGithubUser(user: GithubUser?, withError error: HomeScreenError?)
}
