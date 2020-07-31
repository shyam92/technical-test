//
//  NetworkManagerTests.swift
//  Rightmove TestTests
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import XCTest
@testable import Rightmove_Test
class NetworkManagerTests: XCTestCase {

    func testValidURLPropertyFeed() {
        let networkManager = NetworkManager()
        
        let propertiesExpectation = expectation(description: "data")
        var dataReturned: Properties?
        
        networkManager.propertyFeed() { (result) in
            switch result {
            case .success(let properties):
                dataReturned = properties
            case .failure( _):
                dataReturned = nil
            }
            propertiesExpectation.fulfill()
            XCTAssertTrue(dataReturned?.properties.count == 9, "Invalid Data returned")

        }
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    /**
    This test will give a invalid url to see if it would fail with correct error handling with Invalid url
    */
    func testInvalidURLPropertyFeed() {
        let mockURLBuilder = MockURLBuilder()
        let networkManager = NetworkManager(configuration: .default, urlBuilder: mockURLBuilder)
        let propertiesInvalidExpectation = expectation(description: "data")

        networkManager.propertyFeed { (result) in
            propertiesInvalidExpectation.fulfill()
            switch result {
            case.success(_):
                XCTFail("Valid Data came back where it should have invalid url")
                break
            case .failure(let error):
                XCTAssertTrue(error == .invalidUrl, "Invalid url was not the failure")
            }
        }
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    /**
     This test will give a valid url but invalid data to see if it would fail with correct error handling
     */
    func testValidURLInvalidPropertyFeed() {
        var mockURLBuilder = MockURLBuilder()
        mockURLBuilder.apiURL = "https://jsonplaceholder.typicode.com/todos/1"
        let networkManager = NetworkManager(configuration: .default, urlBuilder: mockURLBuilder)
        let propertiesInvalidExpectation = expectation(description: "data")

        networkManager.propertyFeed { (result) in
            propertiesInvalidExpectation.fulfill()
            switch result {   
            case.success(_):
                XCTFail("Valid Data came back where it should have invalid data")
                break
            case .failure(let error):
                XCTAssertTrue(error == .invalidData, "Invalid data was not the failure")
            }
        }
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    struct MockURLBuilder: URLBuilderProtocol {
        var apiURL: String = ""
        
        func url(for endpoint: Endpoints) -> URL? {
            switch endpoint {
            case .properties:
                return URL(string: apiURL)
            }
        }
    }

}



