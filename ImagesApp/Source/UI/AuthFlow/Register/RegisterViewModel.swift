//
//  RegisterViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 12.02.2025.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

enum RegisterViewModelOutputEvent: ViewModelEvent {
    case registered
    case haveAnAccount
}

enum RegisterViewInputEvent {
    case lock
    case unlock
    case generalError(String)
    case emailError(String)
    case passwordError(String)
    case confirmPasswordError(String)
}

final class RegisterViewModel: BaseViewModel<RegisterViewModelOutputEvent> {
    
    var viewInputEvent = PublishRelay<RegisterViewInputEvent>()
    
    func handleRegister(email: String?, password: String?, confirmPassword: String?) {
        var inputIsValid = true

        if let email, EmailValidator.isValid(email) {
            self.viewInputEvent.accept(.emailError(""))
        } else {
            inputIsValid = false
            self.viewInputEvent.accept(.emailError("Incorrect email"))
        }
        
        if let password, PasswordValidator.isValid(password) {
            self.viewInputEvent.accept(.passwordError(""))
        } else {
            inputIsValid = false
            self.viewInputEvent.accept(.passwordError("Incorrect pass"))
        }
        
        if let confirmPassword, PasswordValidator.isValid(confirmPassword) {
            self.viewInputEvent.accept(.passwordError(""))
        } else {
            inputIsValid = false
            self.viewInputEvent.accept(.confirmPasswordError("Incorrect pass"))
        }
        
        if let password, let confirmPassword, password == confirmPassword { } else {
            self.viewInputEvent.accept(.confirmPasswordError("Passwords do not match"))
        }

        if let email, let password, inputIsValid {
            self.registerRequest(email: email, password: password, completion: { result in
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
