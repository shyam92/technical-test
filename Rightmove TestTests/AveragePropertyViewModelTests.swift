//
//  AveragePropertyViewModelTests.swift
//  Rightmove TestTests
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import XCTest
@testable import Rightmove_Test

class AveragePropertyViewModelTests: XCTestCase {
    
    var viewModel: AveragePropertyViewModel?
    
    //MARK: Expectation variables
    var validexpectation: XCTestExpectation?
    var noDataExpectation: XCTestExpectation?
    
    //MARK: Tests
    /**
     Get data and calculate average property prices
     */
    func testGetData() {
        validexpectation = expectation(description: "validExpectation")
        viewModel = AveragePropertyViewModel(delegate: self)
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    func testFailedGetData() {
        let mockURLBuilder = MockURLBuilder()
        let mockNetworkManager = MockNetworkManager(configuration: .default, urlBuilder: mockURLBuilder)
        
        noDataExpectation = expectation(description: "noDataExpectation")
        
        viewModel = AveragePropertyViewModel(networkManager: mockNetworkManager, delegate: self)
        waitForExpectations(timeout: 100, handler: nil)
    }
    
    func testNoPropertiesCalculateAveragePrices() {
        let mockURLBuilder = MockURLBuilder()
        let mockNetworkManager = MockNetworkManager(configuration: .default, urlBuilder: mockURLBuilder)
        viewModel = AveragePropertyViewModel(networkManager: mockNetworkManager, delegate: self)
        
        let average = viewModel?.calculateAveragePropertyPrices()
        XCTAssertTrue(average == -1, "Average was not -1")
    }
    
    //MARK: Test Data
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

//MARK: Delegate
extension AveragePropertyViewModelTests: AveragePropertyDelegate {
    
    
    func didReceiveData() {
        if validexpectation != nil {
            validexpectation?.fulfill()
            XCTAssertNotNil(viewModel?.averagePropertyPrices, "ViewModel did not have any properties")
            XCTAssertTrue(viewModel?.averagePropertyPrices == 410280.778, "Value of properties did not match 410280.778")
        }
    }
    
    func didError(with error: APIError) {
        if noDataExpectation != nil {
            noDataExpectation?.fulfill()
            XCTAssertTrue(error == .invalidUrl, "Was not invalid URL")
        }
    }
    
}
