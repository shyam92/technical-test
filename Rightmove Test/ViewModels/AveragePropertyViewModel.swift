//
//  AveragePropertyViewModel.swift
//  Rightmove Test
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import Foundation
protocol AveragePropertyDelegate {
    func didReceiveData()
    func didError(with error: APIError)
}

class AveragePropertyViewModel {
    
    // Local dependancies
    private let networkManager: NetworkProtocol
    private let delegate: AveragePropertyDelegate
    
    // Variables
    private var properties: Properties?
    public var averagePropertyPrices: Double {
        return calculateAveragePropertyPrices()
    }
    
    // Constructor
    init(networkManager: NetworkProtocol = NetworkManager(), delegate: AveragePropertyDelegate) {
        self.networkManager = networkManager
        self.delegate = delegate
        getData()
    }
    
    /**
     Get Data from network manager then pass through result to delegate
     */
    private func getData() {
        networkManager.propertyFeed() {[weak self] (result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let properties):
                weakSelf.properties = properties
                weakSelf.delegate.didReceiveData()
                break
            case .failure(let error):
                weakSelf.delegate.didError(with: error)
                break
            }
        }
    }
    
    /**
     Calculates the average properties to 3 decimal places from the data received form network manager
     */
    func calculateAveragePropertyPrices() -> Double {
        guard let properties = properties, properties.properties.count > 0 else {
            self.delegate.didError(with: .invalidData)
            return -1
        }
        var totalCost: Int = 0
        properties.properties.forEach({ totalCost += $0.price })
        let average = Double(totalCost) / Double(properties.properties.count)
        return round(average * 1000) / 1000
    }
}
