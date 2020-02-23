//
//  AppDelegate.swift
//  TransitionPizza
//
//  Created by Ricardo Tokashiki on 28/01/2020.
//  Copyright © 2020 Nodes ApS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        let pizzaVC = PizzaViewController.instantiate()
        let navController = UINavigationController(rootViewController: pizzaVC)

        navController.isNavigationBarHidden = true

        window.rootViewController = navController
        window.makeKeyAndVisible()

        return true
    }
}

