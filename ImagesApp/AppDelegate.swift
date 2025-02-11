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
    private var flow: PhoneAppFlow?

    private let services = ServiceContainer.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        self.prepareRootController()
 
        return true
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareRootController() {
        
        self.flow = PhoneAppFlow(presenter: .default, services: self.services)
        self.window.rootViewController = flow?.flowNavigation
        self.window.makeKeyAndVisible()
    }
}

