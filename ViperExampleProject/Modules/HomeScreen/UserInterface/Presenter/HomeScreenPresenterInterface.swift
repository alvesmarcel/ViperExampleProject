// Abstract: HomeScreen presenter interface, which is used by the view to inform of the user initiated events

protocol HomeScreenPresenterInterface: class {
    var view: HomeScreenViewInterface? { get set }
    var interactor: HomeScreenInteractorInterface? { get set }
    var wireframe: HomeScreenWireframeInterface? { get set }
    func getGithubUserAction(withUsername username: String)
}
