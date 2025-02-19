//
//  CustomPresenter.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2025.
//

import UIKit

class NavigationControllerAuthPresenter: NavigationControllerPresenter {
    
    // MARK: -
    // MARK: Variables
    
    static var `auth`: NavigationControllerAuthPresenter {
        return NavigationControllerAuthPresenter(controllerAnimatedTransitioning: AuthFlowTransition())
    }
    
    let controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType?
    
    // MARK: -
    // MARK: Init
    
    init(
        controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType?
    ) {
        self.controllerAnimatedTransitioning = controllerAnimatedTransitioning
    }
}
