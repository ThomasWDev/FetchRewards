//
//  AppDelegate.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 03/27/2021.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appConfiguration: AppConfiguration!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        appConfiguration = AppConfiguration()

        let eventSearchViewController = EventSearchViewController(appConfiguration: appConfiguration)
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor(named: "navigationTint")
        navigationBarAppearace.titleTextAttributes = [.foregroundColor: UIColor(named: "navigationTitle") ?? .white]
        navigationBarAppearace.barTintColor = UIColor(named: "navigationBar")
        navigationBarAppearace.isTranslucent = false

        let navigationController = UINavigationController(rootViewController: eventSearchViewController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

