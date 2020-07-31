//
//  NetworkManager.swift
//  Rightmove Test
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import Foundation

/**
 Protocol of the Network Manager so that ViewModels can use anything that conforms to it
 */
protocol NetworkProtocol: APIProtocol {
    typealias PropertyDataCompletion = (Result<Properties, APIError>) -> Void
    func propertyFeed(completion: PropertyDataCompletion?)
}

/**
 Network Manager that gets data from the REST API, parses it and returns models based on data
 */
class NetworkManager: NetworkProtocol {
    
    let session: URLSession
    let urlBuilder: URLBuilderProtocol
    typealias PropertyDataCompletion = (Result<Properties, APIError>) -> Void
    
    convenience init() {
        self.init(configuration: .default, urlBuilder: URLBuilder())
    }
    
    init(configuration: URLSessionConfiguration, urlBuilder: URLBuilderProtocol) {
        self.session = URLSession(configuration: configuration)
        self.urlBuilder = urlBuilder
    }
    
    /**
     Fetches data from the REST API and returns completion with data
     - parameter completion: Returns Result with data or error
     */
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
