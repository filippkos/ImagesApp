//
//  UIButton+Extension.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit

extension UIButton {
    func toBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(customView: self)
    }
}
