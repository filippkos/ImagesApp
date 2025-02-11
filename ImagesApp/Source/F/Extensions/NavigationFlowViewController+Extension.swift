//
//  Coordinator+Extension.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit

extension NavigationFlowViewController {
    
    // MARK: -
    // MARK: Public
    
    public func presentAlert(alertModel: AlertModel, controller: UIViewController? = nil) {
        let presenter = controller ?? self.flowNavigation
        let alert = UIAlertController(title: alertModel.title, message: alertModel.message, preferredStyle: .alert)
        if !alertModel.actions.isEmpty {
            alertModel.actions.forEach {
                alert.addAction($0)
            }
        } else {
            alert.addAction(UIAlertAction(title: "ок", style: .cancel))
        }
        
        presenter.present(alert, animated: true)
    }
}
