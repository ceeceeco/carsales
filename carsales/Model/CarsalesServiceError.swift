//
//  CarsalesServiceError.swift
//  carsales
//
//  Created by Charisse Co on 6/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import Foundation

enum CarsalesServiceError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
}
