//
//  BarCodeScannerFlow.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 09.04.2025.
//

import UIKit

class BarCodeScannerFlow: NavigationControllerContainer<NavigationControllerDefaultPresenter> {
    
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
        var viewModel = BarCodeScannerViewModel()
        var view = BarCodeScannerView(viewModel: viewModel)

        self.flowNavigation.pushViewController(view, animated: true)
    }
}
