// Abstract: HomeScreen wireframe interface, which is used in the AppDelegate to create the initial screen, and in HomeScreen
// presenter to navigate to the profile detail

import UIKit

protocol HomeScreenWireframeInterface: class {
    static func createHomeScreenViewController() -> UIViewController
    func presentProfileDetail(fromNavigationController navigationController: UINavigationController, withGithubUser user: GithubUser)
}
