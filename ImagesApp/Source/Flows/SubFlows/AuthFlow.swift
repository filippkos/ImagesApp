//
//  AuthFlow.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 05.02.2025.
//

import UIKit

enum AuthFlowOutputEvent {
    case setImagesFlow
}

class AuthFlow: NavigationControllerContainer<NavigationControllerDefaultPresenter> {
    
    public var outputEvents: ((AuthFlowOutputEvent) -> ())?
    
    // MARK: -
    // MARK: Init
    
    override init(presenter: NavigationControllerDefaultPresenter) {
        super.init(presenter: presenter)
        self.prepareLoginController()
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flowNavigation.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareLoginController() {
        let viewModel = LoginViewModel()
        let loginController = LoginView(viewModel: viewModel)
        viewModel.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        self.flowNavigation.setViewControllers([loginController], animated: false)
    }
    
    private func handle(event: LoginViewModelOutputEvent) {
        switch event {
        case .success:
            self.outputEvents?(.setImagesFlow)
        }
    }
}
