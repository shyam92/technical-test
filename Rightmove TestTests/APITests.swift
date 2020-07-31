//
//  APITests.swift
//  Rightmove TestTests
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import XCTest
@testable import Rightmove_Test

class APITests: XCTestCase {
    
    /**
     Test downloading of data and testing if it decodes correctly
     */
    func testValidDecodingTask() {
        let request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/rightmove/Code-Challenge-iOS/master/properties.json")!)
        let networkManger = MockNetworkManager()
        let decodingExpectation = expectation(description: "decoding")
        
        let task = networkManger.decodingTask(with: request, decodingType: Properties.self) { (json, error) in
            decodingExpectation.fulfill()
            guard let json = json else {
                XCTFail("No data was parsed")
                return
            }
            
            if let value = json as? Properties {
                XCTAssertTrue(value.properties.count == 9, "Properties count was not 9")
            }
        }
        task.resume()
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    /**
     Test:
     - Requesting a valid url
     - invalid httpResponse
     
     Error should be .requestFailed
     */
    func testInvalidHttpResponse() {
        let request = URLRequest(url: URL(string: "www.google.com")!)
        let networkManger = MockNetworkManager()
        let decodingExpectation = expectation(description: "invalid decoding")
        
        let task = networkManger.decodingTask(with: request, decodingType: Properties.self) { (json, error) in
            decodingExpectation.fulfill()
            guard let error = error else {
                XCTFail("JSON data was parsed")
                return
            }
            XCTAssertTrue(error == .requestFailed, "Error was not equal to request failed")
        }
        task.resume()
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    /**
     Test Requesting a valid url with valid httpResponse with data that does not parse Properties Type
     */
    func testInvalidDataResponse() {
        let request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!)
        let networkManger = MockNetworkManager()
        let decodingExpectation = expectation(description: "InvalidData")
        
        let task = networkManger.decodingTask(with: request, decodingType: Properties.self) { (json, error) in
            decodingExpectation.fulfill()
            guard let error = error else {
                XCTFail("JSON data was parsed")
                return
            }
            XCTAssertTrue(error == .invalidData, "Error was not equal to invalid Data")
        }
        task.resume()
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    /**
     Test Requesting a valid url with httpResponse == 404
     */
    func testNotFoundDataResponse() {
        let request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/shyam92/demo/master/empty1.json")!)
        let networkManger = MockNetworkManager()
        let decodingExpectation = expectation(description: "NotFound")
        
        let task = networkManger.decodingTask(with: request, decodingType: Properties.self) { (json, error) in
            decodingExpectation.fulfill()
            guard let error = error else {
                XCTFail("JSON data was parsed")
                return
            }
            XCTAssertTrue(error == .requestFailed, "Error was not equal to request failed")
        }
        task.resume()
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    /**
     Test Requesting a valid url with httpResponse == 200
     - data is empty
     */
    func testEmptyDataResponse() {
        let request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/shyam92/demo/master/invalidJson.json")!)
        let networkManger = MockNetworkManager()
        let decodingExpectation = expectation(description: "EmptyData")
        
        let task = networkManger.decodingTask(with: request, decodingType: Properties.self) { (json, error) in
            decodingExpectation.fulfill()
            guard let error = error else {
                XCTFail("JSON data was parsed")
                return
            }
            XCTAssertTrue(error == .invalidData, "Error was not equal to request failed")
        }
        task.resume()
        waitForExpectations(timeout: 100, handler: nil)
    }
}
/**
 Mock Network Manager to use custom URLBuilder and different urlsession to the app
 */
class MockNetworkManager: NetworkProtocol {
    
    var session: URLSession
    
    var urlBuilder: URLBuilderProtocol
    convenience init() {
        self.init(configuration: .default, urlBuilder: URLBuilder())
    }
    
    init(configuration: URLSessionConfiguration, urlBuilder: URLBuilderProtocol) {
        self.session = URLSession(configuration: configuration)
        self.urlBuilder = urlBuilder
    }
    
    func propertyFeed(completion: PropertyDataCompletion?) {
        let propertiesUrl = urlBuilder.url(for: .properties)
        guard let url = propertiesUrl else {
            completion?(Result.failure(.invalidUrl))
            return
        }
        
        fetch(with: url, decode: { (json) -> Properties? in
            guard let properties = json as? Properties else {
                completion?(Result.failure(.invalidData))
                return nil
            }
            return properties
        }, completion: completion)
    }
    
}
