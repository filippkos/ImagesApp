//
//  ProfileFlow.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 07.02.2025.
//

import UIKit

class ProfileFlow: NavigationControllerContainer<NavigationControllerDefaultPresenter> {
    
    // MARK: -
    // MARK: Properties
    
    let services: ServiceContainer
    
    // MARK: -
    // MARK: Init
    
    init(presenter: NavigationControllerDefaultPresenter, services: ServiceContainer) {
        self.services = services
        
        super.init(presenter: presenter)
        
        self.pushImagesContainerViewController()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Private
    
    private func pushImagesContainerViewController() {
        var viewModel = ProfileViewModel()
        var view = ProfileView(viewModel: viewModel)
        viewModel.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        self.flowNavigation.pushViewController(view, animated: true)
    }
    
    private func handle(event: ProfileViewModelOutputEvent) {
        switch event {
        case .logout:
            self.services.logoutDelegate?.didLogout()
        }
    }
    
    private func pushAuthFlow() {
        let flow = AuthFlow(presenter: .default)
        self.flowNavigation.setViewControllers([flow], animated: true)
    }
}
