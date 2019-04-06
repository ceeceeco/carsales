//
//  CarListingPayload.swift
//  carsales
//
//  Created by Charisse Co on 6/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import Foundation

class CarListingPayload: Codable {
    
    let result: [CarOverview]
    
    private enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}
