//
//  Properties.swift
//  Rightmove Test
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import Foundation

/**
 Array of properties
 */
public struct Properties: Codable {
    
    var properties: [Property]
    
    enum CodingKeys: CodingKey {
        case properties
    }
}
