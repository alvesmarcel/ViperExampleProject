// Abstract: HomeScreen delegate, which is listened by the HomeScreen presenter to handle the interactor responses and then update the view

protocol HomeScreenInteractorDelegate: class {
    func didRetrieveGithubUser(user: GithubUser?, withError error: HomeScreenError?)
}
