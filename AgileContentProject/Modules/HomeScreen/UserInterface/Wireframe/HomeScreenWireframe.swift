import UIKit

class HomeScreenWireframe: HomeScreenWireframeInterface {
    
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    static func createHomeScreenViewController() -> UIViewController {
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "InitialNavigationController")
        guard let homeScreenView = navigationController.children.first as? HomeScreenViewController else {
            return UIViewController()
        }
        
        let presenter: HomeScreenPresenterInterface & HomeScreenInteractorDelegate = HomeScreenPresenter()
        let interactor: HomeScreenInteractorInterface  = HomeScreenInteractor()
        let wireframe: HomeScreenWireframeInterface = HomeScreenWireframe()
        
        homeScreenView.presenter = presenter
        presenter.view = homeScreenView
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        let session = URLSession(configuration: .ephemeral)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        session.configuration.waitsForConnectivity = false
        let networkService = NetworkService(session: session)
        interactor.githubAPI = GithubAPI(networkService: networkService)
        
        return navigationController
    }
    
    func presentProfileDetail(fromNavigationController navigationController: UINavigationController) {
        DispatchQueue.main.async {
            navigationController.pushViewController(ProfileDetailWireframe.createProfileDetailViewController(), animated: true)
        }
    }

}
