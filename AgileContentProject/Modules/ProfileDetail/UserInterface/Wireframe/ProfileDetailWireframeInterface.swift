import UIKit

protocol ProfileDetailWireframeInterface: class {
    static func createProfileDetailViewController(withGithubUser user: GithubUser) -> UIViewController
}
