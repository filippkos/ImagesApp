//
//  LoginViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

enum LoginViewModelOutputEvent: ViewModelEvent {
    case success
    case createAccount
}

enum LoginViewInputEvent {
    case lock
    case unlock
    case generalError(String)
    case emailError(String)
    case passwordError(String)
}

final class LoginViewModel: BaseViewModel<LoginViewModelOutputEvent> {
    
    
    var viewInputEvent = PublishRelay<LoginViewInputEvent>()
    
    func handleLogin(email: String?, password: String?) {
        var inputIsValid = true

        if let email, EmailValidator.isValid(email) { } else {
            inputIsValid = false
            self.viewInputEvent.accept(.emailError("Incorrect email"))
        }

        if let email, let password, inputIsValid {
            self.loginRequest(email: email, password: password)
        }
    }
    
    func handleCreateAccount() {
        self.outputEvents?(.createAccount)
    }
    
    // MARK: -
    // MARK: Private
    
    private func loginRequest(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
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
