//
//  TabBarController.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 06.02.2025.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: -
    // MARK: Properties
    
    var services: ServiceContainer
    
    // MARK: -
    // MARK: Init
    
    init(services: ServiceContainer) {
        self.services = services
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepare()
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepare() {
        self.prepareControllers()
    }
    
    private func prepareControllers() {
        let imagesFlow = ImagesFlow(presenter: .default)
        let profileFlow = ProfileFlow(presenter: .default, services: self.services)
        
        imagesFlow.tabBarItem = UITabBarItem(
            title: "Images",
            image: UIImage(systemName: "timer"),
            selectedImage: nil
        )
        profileFlow.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "mappin.circle"),
            selectedImage: nil
        )
        
        self.setViewControllers(
            [
                imagesFlow,
                profileFlow,
            ],
            animated: false
        )
    }
}
