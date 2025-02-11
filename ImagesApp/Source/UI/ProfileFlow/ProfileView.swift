//
//  ProfileView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 07.02.2025.
//

import UIKit
import FirebaseAuth

final class ProfileView: BaseView<ProfileViewModel, ProfileViewModelOutputEvent> {
    
    // MARK: -
    // MARK: Variables
    
    let stackView = UIStackView()
    let loginField = CustomTextField()
    let uidField = CustomTextField()
    let logoutButton = UIButton()
    
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
        self.prepareData()
    }
    
    private func prepareButton() {
        self.logoutButton.setTitle("Log Out", for: .normal)
        self.logoutButton.frame = CGRect(x: 100, y: 200, width: 150, height: 50)
        self.logoutButton.backgroundColor = .brown
        self.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
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
        self.uidField.titleText = "UID"
        self.stackView.addArrangedSubview(self.uidField)
        self.stackView.addArrangedSubview(UIView())
        self.stackView.addArrangedSubview(self.logoutButton)
        self.stackView.addArrangedSubview(UIView())
        self.prepareConstraints()
    }
    
    private func prepareData() {
        let data = self.viewModel.user()
        self.loginField.text = data.0
        self.uidField.text = data.1
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc func logoutButtonTapped() {
        self.viewModel.logout()
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
