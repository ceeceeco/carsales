//
//  AppCoordinator.swift
//  carsales
//
//  Created by Charisse Co on 7/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    private let window: UIWindow
    
    private let navigationController: UINavigationController
    
    private let service: CarsalesService
    
    init(
        window: UIWindow, navigationController:
        UINavigationController = UINavigationController(),
        service: CarsalesService = RetailCarsalesService()) {
        self.window = window
        self.navigationController = navigationController
        self.service = service
    }

    func start() {
        let viewModel = CarListingTableViewModel(service: service, onListingSelect: { [weak self] detailsUrl in
            self?.showCarDetailsViewController(of: detailsUrl)
        })
        let viewController = CarListingTableViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func showCarDetailsViewController(of detailsUrl: String) {
        let viewModel = CarDetailsViewModel(service: service, detailsUrl: detailsUrl)
        let viewController = CarDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
