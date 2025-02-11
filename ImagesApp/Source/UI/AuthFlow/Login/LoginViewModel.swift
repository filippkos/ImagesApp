//
//  LoginViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit
import FirebaseAuth

enum LoginViewModelOutputEvent: ViewModelEvent {
    case success
}

enum LoginViewInputEvent {
    case lock
    case unlock
    case generalError(String)
    case emailError(String)
    case passwordError(String)
}

final class LoginViewModel: BaseViewModel<LoginViewModelOutputEvent> {
    
    func handleLogin(login: String?, password: String?) {
        var inputIsValid = true
//
//        if let email, EmailValidator.isValid(email) { } else {
//            inputIsValid = false
//            self.viewInput.accept(.emailError(L10n.Validation.emailIncorrect))
//        }
//
//        if let password, PasswordValidator.isValid(password) { } else {
//            inputIsValid = false
//            self.viewInput.accept(.passwordError(L10n.Validation.passwordLength))
//        }

        if let login, let password, inputIsValid {
            self.loginRequest(login: login, password: password)
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func loginRequest(login: String, password: String) {
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
              
            if let error = error {
                
                return
            }

            guard let user = authResult?.user else {
   
                return
            }
            
            strongSelf.outputEvents?(.success)
        }
    }
}
