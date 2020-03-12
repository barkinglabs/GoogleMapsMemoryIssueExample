//
//  AppDelegate.swift
//  GoogleMapsMemoryTest
//
//  Created by Philip Hubert on 3/11/20.
//  Copyright © 2020 Philip Hubert. All rights reserved.
//

import GoogleMaps
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let yourAPIKey = ""
        GMSServices.provideAPIKey(yourAPIKey)

        window = UIWindow(frame: UIScreen.main.bounds)
        let masterController = MasterViewController()

        if (UIDevice.current.userInterfaceIdiom == .phone) {
            navigationController = UINavigationController(rootViewController: masterController)
            navigationController?.navigationBar.isTranslucent = false
            window?.rootViewController = navigationController
        }

        window?.makeKeyAndVisible()

        return true
    }
}

