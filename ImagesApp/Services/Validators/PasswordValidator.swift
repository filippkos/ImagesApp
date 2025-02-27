//
//  PasswordValidator.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 26.02.2025.
//

import Foundation

public final class PasswordValidator {
    
    public static let minLength = 6
    
    public static func isValid(_ password: String) -> Bool {
        return password.count >= Self.minLength
    }
}
