import UIKit

class ProfileDetailWireframe: ProfileDetailWireframeInterface {
    
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    static func createProfileDetailViewController() -> UIViewController {
        guard let profileDetailVC = mainStoryboard.instantiateViewController(withIdentifier: "ProfileDetailViewController") as? ProfileDetailViewController else {
            return UIViewController()
        }
        
        // TODO: Connect dependencies
        
        return profileDetailVC
    }
    
}
