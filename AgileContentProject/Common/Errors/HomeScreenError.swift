// Abstract: An enumeration with the possible errors that can be found on HomeScreen module

enum HomeScreenError: Error {
    init?(error: Error?) {
        guard let error = error else { return nil }
        switch error.localizedDescription {
        case "Inexistent user":
            self = .inexistentUser
        case "The Internet connection appears to be offline.":
            self = .connectionError
        case "Invalid Github Username":
            self = .invalidGithubUsername
        default:
            return nil
        }
    }
    case connectionError
    case inexistentUser
    case invalidGithubUsername
}
