//
//  NavigationControllerDefaultPresenter.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 10.02.2025.
//

import UIKit

class NavigationControllerDefaultPresenter: NavigationControllerPresenter {
    
    // MARK: -
    // MARK: Variables
    
    static var `default`: NavigationControllerDefaultPresenter {
        return NavigationControllerDefaultPresenter()
    }
    
    let controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType?
    
    // MARK: -
    // MARK: Init
    
    init() {
        self.controllerAnimatedTransitioning = nil
    }
}
