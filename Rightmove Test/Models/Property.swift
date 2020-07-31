//
//  Property.swift
//  Rightmove Test
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import Foundation

/**
 Property with the details of the models
 */
public struct Property: Codable {
    
    var id: Int
    var price: Int
    var bedrooms: Int
    var bathrooms: Int
    var number: String
    var address: String
    var region: String
    var postcode: String
    var propertyType: PropertyType
    
    enum CodingKeys: CodingKey {
        case id
        case price
        case bedrooms
        case bathrooms
        case number
        case address
        case region
        case postcode
        case propertyType
    }
    
}

/**
 Property Type based on type of housing
 */
public enum PropertyType: String, Codable {
    case detached = "DETACHED"
    case terraced = "TERRACED"
    case flat = "FLAT"
    case semiDetached = "SEMI_DETACHED"
}
