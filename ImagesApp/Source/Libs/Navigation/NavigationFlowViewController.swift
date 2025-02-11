//
//  NavigationFlowViewController.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 10.02.2025.
//

import UIKit

class NavigationFlowViewController<Presenter: NavigationControllerPresenter>: UINavigationController {

    // MARK: - Properties
    
    var flowNavigation: UINavigationController { self }
    
    let presenter: Presenter

    // MARK: - Initializations and Deallocations
    
    init(presenter: Presenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not allowed.")
    }
}
