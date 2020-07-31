//
//  PropertiesTests.swift
//  Rightmove TestTests
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import XCTest
@testable import Rightmove_Test

class PropertiesTests: XCTestCase {
    
    func testValidPropertiesData() {
        let jsonData = Data(validJsonString.utf8)
        do {
            let rightmoveData = try JSONDecoder().decode(Properties.self, from: jsonData)
            XCTAssertTrue(rightmoveData.properties.count == 2, "Properties count not equal to 2")
            guard let firstProperty = rightmoveData.properties.first else {
                XCTFail("Properties did not have one item")
                return
            }
            guard let lastProperty = rightmoveData.properties.last else {
                XCTFail("Properties did not have more than item")
                return
            }
            XCTAssertTrue(firstProperty.id == 1, "First Property id not equal to 1")
            XCTAssertTrue(firstProperty.price == 1000000, "First property price was not 1000000")
            XCTAssertTrue(firstProperty.bedrooms == 7, "First property bedrooms not 7")
            XCTAssertTrue(firstProperty.bathrooms == 2, "First property bathrooms not 2")
            XCTAssertTrue(firstProperty.number == "12", "First property number is not 12")
            XCTAssertTrue(firstProperty.address == "Richard Lane", "First property address not Richard Lane")
            XCTAssertTrue(firstProperty.region == "London", "First property region not London")
            XCTAssertTrue(firstProperty.postcode == "W1F 3FT", "First property postcode not 'W1F 3FT'")
            XCTAssertTrue(firstProperty.propertyType == .detached, "Property Type for first property is not DETACHED")
            
            XCTAssertTrue(lastProperty.id == 2, "Last Property id not equal to 1")
            XCTAssertTrue(lastProperty.price == 100000, "Last property price was not 100000")
            XCTAssertTrue(lastProperty.bedrooms == 2, "Last property bedrooms not 2")
            XCTAssertTrue(lastProperty.bathrooms == 1, "Last property bathrooms not 1")
            XCTAssertTrue(lastProperty.number == "22", "Last property number is not 22")
            XCTAssertTrue(lastProperty.address == "Brick Road", "Last property address not Brick Road")
            XCTAssertTrue(lastProperty.region == "Sheffield", "Last property region not Sheffield")
            XCTAssertTrue(lastProperty.postcode == "SH1 1AW", "Last property postcode not 'SH1 1AW'")
            XCTAssertTrue(lastProperty.propertyType == .terraced, "Property Type for Last property is not terraced")
        } catch (let error) {
            XCTFail("Error parsing Properties Model = \(error.localizedDescription)")
        }
        
    }
    
    let validJsonString = """
    {
        "properties": [
        {
            "id": 1,
            "price": 1000000,
            "bedrooms": 7,
            "bathrooms": 2,
            "number": "12",
            "address": "Richard Lane",
            "region": "London",
            "postcode": "W1F 3FT",
            "propertyType": "DETACHED"
        },
        {
            "id": 2,
            "price": 100000,
            "bedrooms": 2,
            "bathrooms": 1,
            "number": "22",
            "address": "Brick Road",
            "region": "Sheffield",
            "postcode": "SH1 1AW",
            "propertyType": "TERRACED"
        }]
    }
    """
}
