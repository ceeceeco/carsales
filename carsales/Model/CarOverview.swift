//
//  CarOverview.swift
//  carsales
//
//  Created by Charisse Co on 6/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import Foundation

class CarOverview: Codable {
    
    let id: String
    let title: String
    let location: String
    let price: String
    let mainPhoto: String
    let detailsUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case location = "Location"
        case price = "Price"
        case mainPhoto = "MainPhoto"
        case detailsUrl = "DetailsUrl"
    }
}
