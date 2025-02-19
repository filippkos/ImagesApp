//
//  NavigationDelegate.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2025.
//

import UIKit

class FlowNavigationDelegate<Presenter: NavigationControllerPresenter>: NSObject, UINavigationControllerDelegate {
    
    // MARK: -
    // MARK: Variables
    
    let presenter: Presenter
    
    // MARK: -
    // MARK: Init
    
    init(presenter: Presenter) {
        self.presenter = presenter
        
        super.init()
    }
    
    // MARK: -
    // MARK: UINavigationControllerDelegate
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let controllerAnimatedTransitioning = self.presenter.controllerAnimatedTransitioning
        
        return controllerAnimatedTransitioning
    }
}

