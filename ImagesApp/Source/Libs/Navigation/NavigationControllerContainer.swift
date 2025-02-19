//
//  NavigationControllerContainer.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 09.02.2025.
//

import UIKit

class NavigationControllerContainer<Presenter: NavigationControllerPresenter>: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    let presenter: Presenter
    let flowNavigation: UINavigationController
    
    private let flowNavigationDelegate: FlowNavigationDelegate<Presenter>
    
    // MARK: -
    // MARK: Init
    
    init(presenter: Presenter) {
        let flowNavigation = UINavigationController()
        
        self.presenter = presenter
        self.flowNavigation = flowNavigation
        self.flowNavigationDelegate = FlowNavigationDelegate(presenter: presenter)
        self.flowNavigation.delegate = self.flowNavigationDelegate
        
        super.init(nibName: nil, bundle: nil)
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addContainerController()
    }
    
    // MARK: -
    // MARK: Open
    
    open func setup() {
         
    }
    
    // MARK: -
    // MARK: Private
    
    private func addContainerController() {
        let container = self.flowNavigation
        
        if let childView = container.view {
            self.addChild(container)
            
            childView.frame = self.view.frame
            self.view.addSubview(childView)
            
            childView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                childView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                childView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                childView.topAnchor.constraint(equalTo: self.view.topAnchor),
                childView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
            
            container.didMove(toParent: self)
        }
    }
}
