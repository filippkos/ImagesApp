//
//  LoginView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit
import FirebaseAuth

final class LoginView: BaseView<LoginViewModel, LoginViewModelOutputEvent> {
    
    // MARK: -
    // MARK: Variables
    
    let stackView = UIStackView()
    let loginField = CustomTextField()
    let passwordField = CustomTextField()
    let loginButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let handle = Auth.auth().addStateDidChangeListener { auth, user in
          print()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.prepareButton()
    }
    
    private func prepareButton() {
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.frame = CGRect(x: 100, y: 200, width: 150, height: 50)
        self.loginButton.backgroundColor = .brown
        self.loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func prepareView() {
        self.view.addSubview(self.stackView)
        self.stackView.backgroundColor = .cyan
        self.stackView.axis = .vertical
        self.stackView.spacing = 10
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.loginField.titleText = "Login"
        self.stackView.addArrangedSubview(self.loginField)
        self.stackView.addArrangedSubview(UIView())
        self.passwordField.titleText = "Password"
        self.stackView.addArrangedSubview(self.passwordField)
        self.stackView.addArrangedSubview(UIView())
        self.stackView.addArrangedSubview(self.loginButton)
        self.stackView.addArrangedSubview(UIView())
        self.prepareConstraints()
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc func buttonTapped() {
        let login = self.loginField.text
        let password = self.passwordField.text
        
        self.viewModel.handleLogin(login: login, password: password)
    }
    
    private func handleInput(event: LoginViewInputEvent) {
        switch event {
        case .lock:
            return
//            self.lock()
        case .unlock:
            return
//            self.unlock()
        case .emailError(let error):
            return
//            self.loginField.error = error
        case .passwordError(let error):
            return
//            self.passwordField.error = error
        case .generalError(let error):
            self.showWarning(message: error)
        }
    }
}
