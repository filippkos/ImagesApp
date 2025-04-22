//
//  NotificationsFlow.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 20.04.2025.
//

import UIKit

class NotificationsFlow: NavigationControllerContainer<NavigationControllerDefaultPresenter> {
    
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
        var viewModel = NotificationsViewModel()
        var view = NotificationsView(viewModel: viewModel)

        self.flowNavigation.pushViewController(view, animated: true)
    }
}
