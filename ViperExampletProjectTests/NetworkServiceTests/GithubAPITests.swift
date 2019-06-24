import XCTest
@testable import AgileContentProject

class GithubAPITests: XCTestCase {
    
    class MockNetworkService: NetworkService {
        var data: Data?
        var error: Error?
        
        override func requestDataFromURL(url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
            completionHandler(data, error)
        }
    }
    
    var githubAPI: GithubAPI!
    let networkService = MockNetworkService(session: URLSession())

    override func setUp() {
        super.setUp()
        githubAPI = GithubAPI(networkService: networkService)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetExistingUser() {
        let jsonURL = Bundle(for: type(of: self)).url(forResource: "existing_user_response", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)

        networkService.data = jsonData
        
        let expectedUser = GithubUser(name: "Marcel O. Alves", username: "alvesmarcel", avatarURL: URL(string: "https://avatars2.githubusercontent.com/u/8361685?v=4")!)
        var actualUser: GithubUser?
        var actualError: Error?
        githubAPI.getUser(withUsername: "alvesmarcel") { (githubUser, error) in
            actualUser = githubUser
            actualError = error
        }
        
        XCTAssertEqual(actualUser?.name, expectedUser.name)
        XCTAssertEqual(actualUser?.username, expectedUser.username)
        XCTAssertEqual(actualUser?.avatarURL, expectedUser.avatarURL)
        XCTAssertNil(actualError)
    }
    
    func testGetInexistentUser() {
        let jsonURL = Bundle(for: type(of: self)).url(forResource: "inexistent_user_response", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)
        
        networkService.data = jsonData
        
        var actualUser: GithubUser?
        var actualError: Error?
        githubAPI.getUser(withUsername: "alvesmarcel1") { (githubUser, error) in
            actualUser = githubUser
            actualError = error
        }
        
        XCTAssertNil(actualUser)
        XCTAssertEqual(actualError?.localizedDescription, "Inexistent user")
    }
    
    func testGetUserNoConnection() {
        networkService.error = NSError(domain: "Connection Error", code: 0, userInfo: [NSLocalizedDescriptionKey : "Connection Error"])
        
        var actualUser: GithubUser?
        var actualError: Error?
        githubAPI.getUser(withUsername: "alvesmarcel1") { (githubUser, error) in
            actualUser = githubUser
            actualError = error
        }
        
        XCTAssertNil(actualUser)
        XCTAssertEqual(actualError?.localizedDescription, "Connection Error")
    }
    
    func testGetUserRepositories() {
        let jsonURL = Bundle(for: type(of: self)).url(forResource: "user_repositories_response", withExtension: "json")!
        let jsonData = try! Data(contentsOf: jsonURL)
        
        networkService.data = jsonData
        
        let expectedRepositories = [
            GithubRepository(name: "ARNeuro", language: "Swift"),
            GithubRepository(name: "blog_resizing_views", language: "Swift"),
            GithubRepository(name: "cs", language: "C++"),
            GithubRepository(name: "ios-nanodegree-meme-me", language: "Swift"),
            GithubRepository(name: "ios-nanodegree-on-the-map", language: "HTML"),
            GithubRepository(name: "ios-nanodegree-pitch-perfect", language: "Swift"),
            GithubRepository(name: "ios-nanodegree-virtual-tourist", language: "Swift"),
            GithubRepository(name: "SlackTextViewController", language: "Objective-C"),
            GithubRepository(name: "V-Voice-Changer", language: "Swift")
        ]
        
        let githubUser = GithubUser(name: "Marcel O. Alves", username: "alvesmarcel", avatarURL: URL(string: "https://avatars2.githubusercontent.com/u/8361685?v=4")!)
        var actualRepositories: [GithubRepository]?
        var actualError: Error?
        
        githubAPI.getUserRepositories(user: githubUser) { (repositories, error) in
            actualRepositories = repositories
            actualError = error
        }
        
        for i in 0..<expectedRepositories.count {
            XCTAssertEqual(expectedRepositories[i].name, actualRepositories![i].name)
            XCTAssertEqual(expectedRepositories[i].language, actualRepositories![i].language)
        }
        
        XCTAssertNil(actualError)
    }
    
    func testGetRepositoriesNoConnection() {
        networkService.error = NSError(domain: "Connection Error", code: 0, userInfo: [NSLocalizedDescriptionKey : "Connection Error"])
        
        let githubUser = GithubUser(name: "Marcel O. Alves", username: "alvesmarcel", avatarURL: URL(string: "https://avatars2.githubusercontent.com/u/8361685?v=4")!)
        var actualRepositories: [GithubRepository]?
        var actualError: Error?
        githubAPI.getUserRepositories(user: githubUser) { (repositories, error) in
            actualRepositories = repositories
            actualError = error
        }
        
        XCTAssertNil(actualRepositories)
        XCTAssertEqual(actualError?.localizedDescription, "Connection Error")
    }

}
