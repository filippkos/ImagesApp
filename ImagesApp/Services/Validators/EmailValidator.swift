//
//  EmailValidator.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 21.02.2025.
//

import Foundation

public final class EmailValidator {
    
    public static func isValid(_ email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        
        return emailTest.evaluate(with: email)
    }
}
