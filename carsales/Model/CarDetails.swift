//
//  CarDetails.swift
//  carsales
//
//  Created by Charisse Co on 6/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import Foundation

class CarDetails: Codable {
    
    class Overview: Codable {
        let location: String
        let price: String
        let photoUrlList: [String]
        
        private enum CodingKeys: String, CodingKey {
            case location = "Location"
            case price = "Price"
            case photoUrlList = "Photos"
        }
    }
    
    let id: String
    let saleStatus: String
    let overview: Overview
    let comments: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case saleStatus = "SaleStatus"
        case overview = "Overview"
        case comments = "Comments"
    }
}

class CarDetailsPayload: Codable {
    let result: [CarDetails]
    
    private enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}
