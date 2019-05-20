// Abstract: Extension of HomeScreenViewController to hide the keyboard when the user press return

import UIKit

extension HomeScreenViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
