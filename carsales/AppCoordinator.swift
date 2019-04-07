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
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = CarListingTableViewModel(service: RetailCarsalesService(), onListingSelect: { _ in })
        let viewController = CarListingTableViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
