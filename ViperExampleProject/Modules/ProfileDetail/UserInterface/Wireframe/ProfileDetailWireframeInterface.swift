// Abstract: ProfileDetail wireframe interface, which is used to create a ProfileDetail view

import UIKit

protocol ProfileDetailWireframeInterface: class {
    static func createProfileDetailViewController(withGithubUser user: GithubUser) -> UIViewController
}
