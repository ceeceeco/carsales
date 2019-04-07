//
//  ViewController.swift
//  carsales
//
//  Created by Charisse Co on 6/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let service: CarsalesService = RetailCarsalesService()

    override func viewDidLoad() {
        super.viewDidLoad()

        service.retrieveListing { [weak self] result in
            switch result {
            case .success(let carLists):
                print(carLists)
                guard let firstCar = carLists.first else { return }
                self?.retrieveCarDetails(firstCar)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func retrieveCarDetails(_ car: CarOverview) {
        service.retrieveCarDetails(detailsUrl: car.detailsUrl) { result in
            print(result)
        }
    }
}

