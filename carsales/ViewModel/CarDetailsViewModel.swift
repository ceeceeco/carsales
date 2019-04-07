//
//  CarDetailsViewModel.swift
//  carsales
//
//  Created by Charisse Co on 7/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

class CarDetailsViewModel {
    
    private let service: CarsalesService
    
    private let detailsUrl: String
    
    private var details: CarDetails?
    
    init(service: CarsalesService, detailsUrl: String) {
        self.service = service
        self.detailsUrl = detailsUrl
    }
    
    var numberOfImages: Int {
        return details?.overview.photoUrlList.count ?? 0
    }
    
    var locationText: String? {
        return details?.overview.location
    }
    
    var priceText: String? {
        return details?.overview.price
    }
    
    var saleStatusText: String? {
        return details?.saleStatus
    }
    
    var commentsText: String? {
        return details?.comments
    }
    
    func retrieveDetails(completion: @escaping () -> Void) {
        service.retrieveCarDetails(detailsUrl: detailsUrl) { [weak self] result in
            switch result {
            case .success(let details): self?.details = details.first
            case .failure(let error): print(error)
            }
            completion()
        }
    }
    
    func retrieveImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = details?.overview.photoUrlList[index] else { return }
        service.retrieveImage(url: imageUrl, completion: completion)
    }
}
