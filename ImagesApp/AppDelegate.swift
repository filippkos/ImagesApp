//
//  AppDelegate.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    private var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        self.prepareRootController()
 
        return true
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareRootController() {
        let navigationController = UINavigationController()
        self.coordinator = AppCoordinator(navigationController: navigationController)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}
