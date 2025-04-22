//
//  UIVIewController+Extension.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 04.02.2025.
//

import UIKit

public extension UIViewController {
    
    func showAlert(
        title: String? = nil,
        message: String?,
        actions: [UIAlertAction]?,
        preferredAction: UIAlertAction? = nil,
        style: UIAlertController.Style = .alert
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions?.forEach { alertController.addAction($0) }
        alertController.preferredAction = preferredAction
        
        if let popoverController = alertController.popoverPresentationController {
            let bounds = self.view.bounds
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: bounds.midX, y: bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showWarning(
        title: String? = nil,
        message: String,
        actionTitle: String = "Ok",
        actionIsPreferred: Bool = false,
        action: ((UIAlertAction) -> Void)? = nil
    ) {
        let action = UIAlertAction(title: actionTitle, style: .default, handler: action)
        let preferred = actionIsPreferred ? action : nil
        self.showAlert(title: title, message: message, actions: [action], preferredAction: preferred)
    }
    
    func presentConfirmationAlert(
        title: String,
        message: String,
        confirmTitle: String = "Ok",
        cancelTitle: String = "Cancel",
        confirmHandler: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
            confirmHandler()
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
}
