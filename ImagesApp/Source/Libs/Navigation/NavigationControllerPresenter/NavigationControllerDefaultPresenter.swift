//
//  NavigationControllerDefaultPresenter.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 10.02.2025.
//

import UIKit

class NavigationControllerDefaultPresenter: NavigationControllerPresenter {
    
    static var `default`: NavigationControllerDefaultPresenter {
        return NavigationControllerDefaultPresenter()
    }
    
    let controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType?
    
    // MARK: - Initializations and Deallocations
    
    init() {
        self.controllerAnimatedTransitioning = nil
    }
}
