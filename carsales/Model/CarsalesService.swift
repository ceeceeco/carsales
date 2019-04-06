//
//  CarsalesService.swift
//  carsales
//
//  Created by Charisse Co on 6/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import Foundation

typealias RetrieveListingResult = Result<[CarOverview], Error>
typealias RetrieveListingCallback = (RetrieveListingResult) -> Void

typealias RetrieveCarDetailsResult = Result<[CarDetails], Error>
typealias RetrieveCarDetailsCallback = (RetrieveCarDetailsResult) -> Void

protocol CarsalesService {

    func retrieveListing(completion: @escaping RetrieveListingCallback)
    
    func retrieveCarDetails(detailsUrl: String, completion: @escaping RetrieveCarDetailsCallback)
}
