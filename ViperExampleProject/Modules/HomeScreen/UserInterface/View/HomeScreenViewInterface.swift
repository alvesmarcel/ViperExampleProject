// Abstract: HomeScreen view interface, which is used by the presenter to update the view based on the interactor responses

import UIKit

protocol HomeScreenViewInterface: class {
    func showErrorMessage(title: String, message: String)
}
