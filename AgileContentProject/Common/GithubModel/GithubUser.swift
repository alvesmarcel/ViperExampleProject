// Abstract: Github user container

import Foundation

struct GithubUser: Codable {
    let name: String
    let username: String
    let avatarURL: URL
}
