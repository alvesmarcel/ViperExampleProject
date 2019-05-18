//
//  NetworkServiceTests.swift
//  AgileContentProjectTests
//
//  Created by Marcel Oliveira Alves on 5/17/19.
//  Copyright © 2019 Marcel Oliveira Alves. All rights reserved.
//

import XCTest
@testable import AgileContentProject

class MockURLSession: URLSessionProtocol {
    var nextData: Data?
    var nextError: Error?
    var nextDataTask = MockURLSessionDataTask()
    private (set) var lastURL: URL?
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        lastURL = url
        completionHandler(nextData, nil, nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    func resume() {
        resumeWasCalled = true
    }
}

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    let session = MockURLSession()

    override func setUp() {
        super.setUp()
        networkService = NetworkService(session: self.session)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRequestStart() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        guard let url = URL(string: "https://api.github.com/users/") else {
            fatalError("Invalid URL")
        }
        networkService.requestDataFromURL(url: url) { (_, _) in }
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testRequestSuccessful() {
        let expectedData = "{}".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        
        guard let url = URL(string: "https://api.github.com/users/") else {
            fatalError("Invalid URL")
        }
        
        var actualData: Data?
        var actualError: Error?
        
        networkService.requestDataFromURL(url: url) { (data, error) in
            actualData = data
            actualError = error
        }
        
        XCTAssertEqual(actualData, expectedData)
        XCTAssertNil(actualError)
    }
    
    func testRequestFailed() {
        let expectedError = NetworkService.NetworkError.connectionFailed
        session.nextError = expectedError
        
        guard let url = URL(string: "https://api.github.com/users/") else {
            fatalError("Invalid URL")
        }
        
        var actualData: Data?
        var actualError: NetworkService.NetworkError?
        
        networkService.requestDataFromURL(url: url) { (data, error) in
            actualData = data
            actualError = error
        }
        
        XCTAssertEqual(actualError, expectedError)
        XCTAssertNil(actualData)
    }

}
