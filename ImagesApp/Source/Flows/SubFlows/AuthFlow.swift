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

class AuthFlow: NavigationControllerContainer<NavigationControllerAuthPresenter> {
    
    public var outputEvents: ((AuthFlowOutputEvent) -> ())?
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flowNavigation.setNavigationBarHidden(true, animated: false)
    }
    
    override func setup() {
        super.setup()
        
        self.prepareLoginController()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareLoginController() {
        let viewModel = LoginViewModel()
        let view = LoginView(viewModel: viewModel)
        viewModel.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        self.flowNavigation.setViewControllers([view], animated: true)
    }
    
    private func handle(event: LoginViewModelOutputEvent) {
        switch event {
        case .success:
            self.outputEvents?(.setImagesFlow)
        case .failure(let error):
            self.showWarning(message: error.localizedDescription)
        case .createAccount:
            self.pushRegisterController()

        }
    }
    
    private func pushRegisterController() {
        let viewModel = RegisterViewModel()
        let view = RegisterView(viewModel: viewModel)
        viewModel.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        self.flowNavigation.pushViewController(view, animated: true)
    }
    
    private func handle(event: RegisterViewModelOutputEvent) {
        switch event {
        case .registered:
            self.outputEvents?(.setImagesFlow)
        case .haveAnAccount:
            self.prepareLoginController()
        }
    }
}
