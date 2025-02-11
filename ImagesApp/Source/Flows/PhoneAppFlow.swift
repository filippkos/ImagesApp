//
//  PhoneAppFlow.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 05.02.2025.
//

import UIKit
import FirebaseAuth

public protocol LogoutDelegate: AnyObject {
    
    func didLogout()
}

class PhoneAppFlow: NavigationFlowViewController<NavigationControllerDefaultPresenter>, LogoutDelegate {
    
    // MARK: -
    // MARK: Properties
    
    let services: ServiceContainer
    
    // MARK: -
    // MARK: Init
    
    init(presenter: NavigationControllerDefaultPresenter, services: ServiceContainer) {
        self.services = services
        
        super.init(presenter: presenter)
        
        self.services.logoutDelegate = self
        self.checkAuthState()
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flowNavigation.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: -
    // MARK: Private
    
    func checkAuthState() {
        if let user = Auth.auth().currentUser {
            user.getIDToken { token, error in
                if let error = error {
                    self.showAuthFlow()
                } else {
                    self.showImagesFlow()
                }
            }
        } else {
            self.showAuthFlow()
        }
    }
    
    private func showAuthFlow() {
        let flow = AuthFlow(presenter: .default)
        flow.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        self.flowNavigation.setViewControllers([flow], animated: true)
    }
    
    private func handle(event: AuthFlowOutputEvent) {
        switch event {
        case .setImagesFlow:
            self.showImagesFlow()
        }
    }
    
    private func showImagesFlow() {
        let flow = TabBarController(services: self.services)
        self.flowNavigation.setViewControllers([flow], animated: true)
    }
    
    // MARK: -
    // MARK: Logout Delegate
    
    func didLogout() {
        self.showAuthFlow()
    }
}


