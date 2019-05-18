protocol HomeScreenPresenterInterface: class {
    var view: HomeScreenViewInterface? { get set }
    var interactor: HomeScreenInteractorInterface? { get set }
    var wireframe: HomeScreenWireframeInterface? { get set }
    func getGithubUserAction(withUsername username: String)
}
