// Abstract: ProfileDetail delegate, which is listened by the ProfileDetail presenter to handle the interactor responses and then
// update the view

import Foundation

protocol ProfileDetailInteractorDelegate: class {
    func didRetrieveGithubUserRepositories(_ repositories: [GithubRepository])
    func didRetrieveGithubUserAvatar(imageData: Data)
    func onError(_ error: Error)
}
