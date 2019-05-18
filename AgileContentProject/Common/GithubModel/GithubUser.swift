// Abstract: Github user container

import Foundation

struct GithubUser: Codable {
    let username: String
    let avatarURL: URL?
}
