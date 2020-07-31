//
//  URLBuilder.swift
//  Rightmove Test
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import Foundation

/**
 Protocol to create URL and use it in the API Protocol
 */
protocol URLBuilderProtocol {
    var apiURL: String { get set }
    func url(for endpoint: Endpoints) -> URL?
}

/**
 List of Endpoints
 */
enum Endpoints: String {
    case properties
}

/**
 URLBuilder conforming to URLBuilderProtocol with Production data
 */
class URLBuilder: URLBuilderProtocol {
    
    var apiURL = "https://raw.githubusercontent.com/rightmove/Code-Challenge-iOS/master/"
    
    func url(for endpoint: Endpoints) -> URL? {
        switch endpoint {
        case .properties:
            return URL(string: apiURL + "properties.json")
        }
    }
}
