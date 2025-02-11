//
//  Coordinator.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit

class ImagesFlow: NavigationControllerContainer<NavigationControllerDefaultPresenter> {
    
    // MARK: -
    // MARK: Init
    
    override init(presenter: NavigationControllerDefaultPresenter) {
        super.init(presenter: presenter)
        self.pushImagesContainerViewController()
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Private
    
    private func pushImagesContainerViewController() {
        let viewModel = ImagesViewModel()
        let containerController = ImagesView(viewModel: viewModel)
        viewModel.outputEvents = { [weak self] event in
            self?.handle(event: event)
        }
        self.flowNavigation.pushViewController(containerController, animated: true)
    }
    
    private func handle(event: ImagesViewModelOutputEvent) {
        switch event {
        case let .showDetailed(image):
            self.pushDetailedImageViewController(image: image)
        }
    }
    
    private func pushDetailedImageViewController(image: UIImage) {
        let viewModel = DetailedImageViewModel()
        let containerController = DetailedImageView(viewModel: viewModel)
        containerController.configure(with: image)
        self.flowNavigation.pushViewController(containerController, animated: true)
    }
}
