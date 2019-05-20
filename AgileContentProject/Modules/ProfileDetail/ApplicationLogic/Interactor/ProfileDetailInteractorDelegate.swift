import Foundation

protocol ProfileDetailInteractorDelegate: class {
    func didRetrieveGithubUserRepositories(repositories: [GithubRepository]?, withError error: Error?)
    func didRetrieveGithubUserAvatar(imageData: Data)
}
