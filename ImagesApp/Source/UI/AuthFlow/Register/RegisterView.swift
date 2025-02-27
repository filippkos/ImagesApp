//
//  RegisterView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 12.02.2025.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

final class RegisterView: BaseView<RegisterViewModel, RegisterViewModelOutputEvent> {
    
    // MARK: -
    // MARK: Variables
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let titleStack = UIStackView()
    let stackView = UIStackView()
    let loginField = CustomTextField()
    let passwordField = CustomTextField()
    let confirmPasswordField = CustomTextField()
    let registerButton = UIButton()
    let labelContainer = UIView()
    let haveAnAccountLabel = UILabel()
    
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
        self.prepareHaveAnAccountLabel()
        self.prepareConstraints()
        self.setupBindings()
    }
    
    // MARK: -
    // MARK: Private
    
    private func setupBindings() {
        self.viewModel.viewInputEvent
            .observe(on: MainScheduler.instance)
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
        self.titleLabel.text = "Create Account"
        self.titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        self.descriptionLabel.text = "Create an account"
        self.descriptionLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        self.titleStack.addArrangedSubview(self.titleLabel)
        self.titleStack.addArrangedSubview(self.descriptionLabel)
    }
    
    private func prepareView() {
        self.view.addSubview(self.stackView)
        self.view.addSubview(self.titleStack)
        self.view.backgroundColor = .white
        self.stackView.backgroundColor = .white
        self.stackView.axis = .vertical
        self.stackView.spacing = 30
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.loginField.placeholder = "Login"
        self.stackView.addArrangedSubview(self.loginField)
        self.passwordField.placeholder = "Password"
        self.stackView.addArrangedSubview(self.passwordField)
        self.confirmPasswordField.placeholder = "Confirm Password"
        self.stackView.addArrangedSubview(self.confirmPasswordField)
        self.stackView.addArrangedSubview(self.registerButton)
        self.stackView.addArrangedSubview(self.labelContainer)
        self.stackView.addArrangedSubview(UIView())
    }
    
    private func prepareButton() {
        self.registerButton.setTitle("Register", for: .normal)
        self.registerButton.backgroundColor = UIColor(named: "Colors/surface/primary")
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.registerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func prepareHaveAnAccountLabel() {
        self.haveAnAccountLabel.text = "Already have an account"
        self.haveAnAccountLabel.isUserInteractionEnabled = true
        self.haveAnAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(haveAnAccountLabelTapped(sender:)))
        self.haveAnAccountLabel.addGestureRecognizer(tap)
        self.labelContainer.addSubview(self.haveAnAccountLabel)
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
            self.registerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            self.haveAnAccountLabel.centerXAnchor.constraint(equalTo: self.labelContainer.centerXAnchor),
            self.haveAnAccountLabel.centerYAnchor.constraint(equalTo: self.labelContainer.centerYAnchor),
            self.labelContainer.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func buttonTapped() {
        let email = self.loginField.text
        let password = self.passwordField.text
        let confirmPassword = self.confirmPasswordField.text
        
        self.viewModel.handleRegister(email: email, password: password, confirmPassword: confirmPassword)
    }
    
    @objc func haveAnAccountLabelTapped(sender:UITapGestureRecognizer) {
        self.viewModel.handleHaveAnAccount()
    }
    
    private func handleInput(event: RegisterViewInputEvent) {
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
        case .confirmPasswordError(let error):
            self.confirmPasswordField.error = error
        case .generalError(let error):
            self.showWarning(message: error)
        }
    }
}
