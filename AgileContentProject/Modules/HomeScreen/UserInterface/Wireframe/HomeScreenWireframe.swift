import UIKit

class HomeScreenWireframe: HomeScreenWireframeInterface {
    
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    static func createHomeScreenViewController() -> UIViewController {
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "InitialNavigationController")
        guard let homeScreenView = navigationController.children.first as? HomeScreenViewController else {
            return UIViewController()
        }
        
        // Connecting VIPER parts
        
        let presenter: HomeScreenPresenterInterface & HomeScreenInteractorDelegate = HomeScreenPresenter()
        let interactor: HomeScreenInteractorInterface  = HomeScreenInteractor()
        let wireframe: HomeScreenWireframeInterface = HomeScreenWireframe()
        
        homeScreenView.presenter = presenter
        presenter.view = homeScreenView
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        // Configuring specific dependencies
        
        let session = NetworkService.defaultSession()
        let networkService = NetworkService(session: session)
        interactor.githubAPI = GithubAPI(networkService: networkService)
        
        return navigationController
    }
    
    func presentProfileDetail(fromNavigationController navigationController: UINavigationController, withGithubUser user: GithubUser) {
        DispatchQueue.main.async {
            navigationController.pushViewController(ProfileDetailWireframe.createProfileDetailViewController(withGithubUser: user), animated: true)
        }
    }

}
