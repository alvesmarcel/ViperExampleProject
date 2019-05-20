// Abstract: ProfileDetail delegate, which is listened by the ProfileDetail presenter to handle the interactor responses and then
// update the view

import Foundation

protocol ProfileDetailInteractorDelegate: class {
    func didRetrieveGithubUserRepositories(repositories: [GithubRepository]?, withError error: Error?)
    func didRetrieveGithubUserAvatar(imageData: Data)
}
