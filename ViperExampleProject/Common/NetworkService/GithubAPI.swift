// Abstract: A class that provides the basic functionality to retrieve a Github user or a user's repositories

import Foundation

class GithubAPI {

    static private let githubAPIBaseURL = "https://api.github.com/users/"
    var networkService: NetworkService?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getUser(withUsername username: String, completionHandler: @escaping (_ user: GithubUser?, _ error: Error?) -> Void) {
        // The url should always be valid because the username is validated in the interactor
        // Invalid URL won't crash the app, but it won't warn the user either, since this is an interactor job
        guard let url = URL(string: "\(GithubAPI.githubAPIBaseURL)\(username)") else {
            print("[GithubAPI]: Invalid URL. This should not happen since the username was already checked")
            return
        }
        networkService?.requestDataFromURL(url: url) { requestData, requestError in
            if let jsonData = requestData {
                do {
                    guard let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                        print("[GithubAPI]: Converting JSON data to dictionary did not work")
                        return
                    }
                    
                    // Check if the user exists in the JSON dictionary, and return the GithubUser object if it does
                    // The user "name" can be nil
                    if let username = jsonDict["login"] as? String,
                       let avatarURL = jsonDict["avatar_url"] as? String {
                        let url = URL(string: avatarURL)!
                        let user = GithubUser(name: jsonDict["name"] as? String, username: username, avatarURL: url)
                        completionHandler(user, nil)
                    } else {
                        let error = NSError(domain: "GithubAPI", code: 1, userInfo: [NSLocalizedDescriptionKey : "Inexistent user"])
                        completionHandler(nil, error)
                    }
                } catch {
                    print("[GithubAPI]: Parsing JSON error in getUser(withUsername:completionHandler:)")
                }
            } else {
                // Connection error
                completionHandler(nil, requestError)
            }
        }
    }
    
    func getUserRepositories(user: GithubUser, completionHandler: @escaping (_ repos: [GithubRepository]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "\(GithubAPI.githubAPIBaseURL)\(user.username)/repos") else {
            print("Invalid URL. This should not happen since the username was already checked")
            return
        }
        networkService?.requestDataFromURL(url: url) { requestData, requestError in
            if let jsonData = requestData {
                do {
                    let userRepos = try JSONDecoder().decode([GithubRepository].self, from: jsonData)
                    completionHandler(userRepos, nil)
                } catch let parsingError {
                    print("[GithubAPI]: Parsing JSON error in getUserRepositories(user:completionHandler:)")
                    print(parsingError)
                }
            } else {
                // Connection error
                completionHandler(nil, requestError)
            }
        }
    }
    
}
