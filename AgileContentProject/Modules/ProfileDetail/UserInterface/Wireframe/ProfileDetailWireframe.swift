import UIKit

class ProfileDetailWireframe: ProfileDetailWireframeInterface {
    
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    static func createProfileDetailViewController(withGithubUser user: GithubUser) -> UIViewController {
        guard let profileDetailView = mainStoryboard.instantiateViewController(withIdentifier: "ProfileDetailViewController") as? ProfileDetailViewController else {
            return UIViewController()
        }
        
        // Connecting VIPER parts
        
        let presenter: ProfileDetailPresenterInterface & ProfileDetailInteractorDelegate = ProfileDetailPresenter()
        let interactor: ProfileDetailInteractorInterface  = ProfileDetailInteractor()
        let wireframe: ProfileDetailWireframeInterface = ProfileDetailWireframe()
        
        profileDetailView.presenter = presenter
        presenter.view = profileDetailView
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        // Configuring specific dependencies
        
        let session = NetworkService.defaultSession()
        let networkService = NetworkService(session: session)
        interactor.networkService = networkService
        interactor.githubAPI = GithubAPI(networkService: networkService)
        presenter.githubUser = user
        
        return profileDetailView
    }
    
}
