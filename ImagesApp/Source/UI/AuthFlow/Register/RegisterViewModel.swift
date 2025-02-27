//
//  RegisterViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 12.02.2025.
//

import UIKit
import FirebaseAuth

enum RegisterViewModelOutputEvent: ViewModelEvent {
    case registered
    case haveAnAccount
}

final class RegisterViewModel: BaseViewModel<RegisterViewModelOutputEvent> {
    
    func handleRegister(login: String?, password: String?) {
        var inputIsValid = true

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
            self.registerRequest(email: login, password: password, completion: { result in
                switch result {
                case .success:
                    self.outputEvents?(.registered)
                case .failure:
                return
                }
            })
        }
    }
    
    func handleHaveAnAccount() {
        self.outputEvents?(.haveAnAccount)
    }
    
    // MARK: -
    // MARK: Private
    
    func registerRequest(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
}
