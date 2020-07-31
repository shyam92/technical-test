//
//  URLBuilderTests.swift
//  Rightmove TestTests
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import XCTest
@testable import Rightmove_Test
class URLBuilderTests: XCTestCase {

    func testValidPropertyURL() {
        let urlBuilder = URLBuilder()
        guard let propertiesEndpoint = urlBuilder.url(for: .properties) else {
            XCTFail("Properties Endpoint is nil")
            return
        }
        let expectedURL = "https://raw.githubusercontent.com/rightmove/Code-Challenge-iOS/master/properties.json"
        XCTAssertTrue(propertiesEndpoint.absoluteString == expectedURL, "Expected url is not same properties endpoint")
    }

}
