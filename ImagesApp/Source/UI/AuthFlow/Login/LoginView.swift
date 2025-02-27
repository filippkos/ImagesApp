//
//  LoginView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

final class LoginView: BaseView<LoginViewModel, LoginViewModelOutputEvent> {
    
    // MARK: -
    // MARK: Variables
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let titleStack = UIStackView()
    let stackView = UIStackView()
    let loginField = CustomTextField()
    let passwordField = CustomTextField()
    let loginButton = UIButton()
    let labelContainer = UIView()
    let createAccountLabel = UILabel()
    
    // MARK: -
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let handle = Auth.auth().addStateDidChangeListener { auth, user in
          print()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTitle()
        self.prepareView()
        self.prepareButton()
        self.prepareCreateAccountLabel()
        self.prepareConstraints()
        self.setupBindings()
    }
    
    // MARK: -
    // MARK: Private
    
    private func setupBindings() {
        self.viewModel.viewInputEvent
            .observe(on: MainScheduler.instance) // Обрабатываем события в главном потоке
            .subscribe(onNext: { [weak self] event in
                self?.handleInput(event: event)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func prepareTitle() {
        self.titleStack.axis = .vertical
        self.titleStack.spacing = 26
        self.titleStack.alignment = .center
        self.titleStack.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.text = "Login here"
        self.titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        self.descriptionLabel.text = "Welcome back you’ve been missed!"
        self.descriptionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.titleStack.addArrangedSubview(self.titleLabel)
        self.titleStack.addArrangedSubview(self.descriptionLabel)
    }
    
    private func prepareView() {
        self.view.addSubview(self.titleStack)
        self.view.addSubview(self.stackView)
        self.view.backgroundColor = .white
        self.stackView.backgroundColor = .white
        self.stackView.axis = .vertical
        self.stackView.spacing = 30
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.loginField.placeholder = "Email"
        self.stackView.addArrangedSubview(self.loginField)
        self.passwordField.placeholder = "Password"
        self.stackView.addArrangedSubview(self.passwordField)
        self.stackView.addArrangedSubview(self.loginButton)
        self.stackView.addArrangedSubview(self.labelContainer)
        self.stackView.addArrangedSubview(UIView())
    }
    
    private func prepareButton() {
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.backgroundColor = UIColor(named: "Colors/surface/primary")
        self.loginButton.layer.cornerRadius = 10
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func prepareCreateAccountLabel() {
        self.createAccountLabel.text = "Create new account"
        self.createAccountLabel.isUserInteractionEnabled = true
        self.createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(createAccountLabelTapped(sender:)))
        self.createAccountLabel.addGestureRecognizer(tap)
        self.labelContainer.addSubview(self.createAccountLabel)
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.titleStack.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.titleStack.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.titleStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 97),
            self.titleStack.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -74),
        ])
        
        NSLayoutConstraint.activate([
            self.stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 32),
            self.stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -32),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            self.loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            self.createAccountLabel.centerXAnchor.constraint(equalTo: self.labelContainer.centerXAnchor),
            self.createAccountLabel.centerYAnchor.constraint(equalTo: self.labelContainer.centerYAnchor),
            self.labelContainer.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func loginButtonTapped() {
        let email = self.loginField.text
        let password = self.passwordField.text
        
        self.viewModel.handleLogin(email: email, password: password)
    }
    
    @objc func createAccountLabelTapped(sender:UITapGestureRecognizer) {
        self.viewModel.handleCreateAccount()
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
            self.loginField.error = error
        case .passwordError(let error):
            self.passwordField.error = error
        case .generalError(let error):
            self.showWarning(message: error)
        }
    }
}
