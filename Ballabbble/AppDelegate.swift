//
//  AppDelegate.swift
//  Ballabbble
//
//  Created by Alex Agapov on 29/05/2017.
//  Copyright © 2017 Alex Agapov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        openApplication()

        return true
    }

    private func openApplication() {

        let splashViewController = SplashViewController()
        let navigationController = UINavigationController(rootViewController: splashViewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
