//
//  AppDelegate.swift
//  carsales
//
//  Created by Charisse Co on 6/4/19.
//  Copyright © 2019 Charisse Co. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = AppCoordinator(window: window)
        self.window = window
        self.appCoordinator = coordinator
        coordinator.start()
        return true
    }
}

