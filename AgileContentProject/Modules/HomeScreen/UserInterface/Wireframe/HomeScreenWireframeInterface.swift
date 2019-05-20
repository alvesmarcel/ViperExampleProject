import UIKit

protocol HomeScreenWireframeInterface: class {
    static func createHomeScreenViewController() -> UIViewController
    func presentProfileDetail(fromNavigationController navigationController: UINavigationController)
}
