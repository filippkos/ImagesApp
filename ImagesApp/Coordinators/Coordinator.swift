//
//  Coordinator.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit

public protocol Coordinator: AnyObject {
    
    var navigationViewController: UINavigationController { get set }
    
    func presentAlert(alertModel: AlertModel, controller: UIViewController?)
}

class AppCoordinator: Coordinator {

    // MARK: -
    // MARK: Variables
    
    var navigationViewController: UINavigationController
    
    // MARK: -
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationViewController = navigationController
        self.prepareContainerViewController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareContainerViewController() {
        let viewModel = ImagesViewModel()
        let containerController = ImagesView(viewModel: viewModel)
       
        self.navigationViewController.setViewControllers([containerController], animated: true)
    }
}
