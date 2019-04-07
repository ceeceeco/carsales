//
//  CarListingTableViewModel.swift
//  carsales
//
//  Created by Charisse Co on 7/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

class CarListingTableViewModel {
    
    private let service: CarsalesService
    
    private let onListingSelect: (_ url: String) -> Void
    
    private var listing: [CarOverview]
    
    init(service: CarsalesService, onListingSelect: @escaping (String) -> Void) {
        self.service = service
        self.onListingSelect = onListingSelect
        self.listing = []
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(section: Int) -> Int {
        return listing.count
    }
    
    func textContent(for indexPath: IndexPath) -> (title: String, price: String, location: String)? {
        let index = indexPath.row
        guard index < listing.count else { return nil }
        return (title: listing[index].title, price: listing[index].price, location: listing[index].location)
    }
    
    func id(for indexPath: IndexPath) -> String? {
        return listing[indexPath.row].id
    }
    
    func didSelect(indexPath: IndexPath) {
        guard indexPath.row < listing.count else { return }
        onListingSelect(listing[indexPath.row].detailsUrl)
    }
    
    func retrieveListing(completion: @escaping () -> Void) {
        service.retrieveListing { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success(let listing):
                this.listing = listing
                completion()
            case .failure: break // TODO: - Error handling
            }
        }
    }
    
    func retrieveImage(for indexPath: IndexPath, completion: @escaping (UIImage?) -> Void) {
        guard indexPath.row < listing.count else { return }
        service.retrieveImage(url: listing[indexPath.row].mainPhoto) { image in
            completion(image)
        }
    }
}
