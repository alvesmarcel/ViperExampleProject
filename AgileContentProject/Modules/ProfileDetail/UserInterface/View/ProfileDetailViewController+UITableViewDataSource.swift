import UIKit

extension ProfileDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.userRepositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)
        cell?.textLabel?.text = presenter?.userRepositories?[indexPath.row].name ?? ""
        cell?.detailTextLabel?.text = presenter?.userRepositories?[indexPath.row].language ?? ""
        return cell ?? UITableViewCell()
    }
    
}
