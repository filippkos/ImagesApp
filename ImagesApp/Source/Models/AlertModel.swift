//
//  AlertModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit

public struct AlertModel {
    
    let title: String
    let message: String
    let actions: [UIAlertAction]
    
    public init(title: String, message: String, actions: [UIAlertAction]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    public init(error: Error) {
        self.title = "Error"
        self.message = error.localizedDescription
        self.actions = []
    }
}
