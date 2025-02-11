//
//  NavigationControllerPresenter.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 10.02.2025.
//

import UIKit

protocol NavigationControllerPresenter {
    
    var controllerAnimatedTransitioning: NavigationCoordinatorAnimatorType? { get }
}

protocol NavigationCoordinatorAnimatorType: UIViewControllerAnimatedTransitioning {
    
}
