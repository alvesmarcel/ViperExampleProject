// Abstract: Extension of ProfileDetailViewController to populate its tableView with the data held by the ProfileDetail presenter

import UIKit

extension ProfileDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.userRepositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)
        cell?.textLabel?.text = presenter?.userRepositories?[indexPath.row].name ?? ""
        cell?.detailTextLabel?.text = presenter?.userRepositories?[indexPath.row].language ?? "No language"
        return cell ?? UITableViewCell()
    }
    
}
