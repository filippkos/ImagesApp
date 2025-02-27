//
//  CustomTextField.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit

class CustomTextField: UIView {
    
    var customBackgroundColor: UIColor? {
        didSet { self.fieldContainer.backgroundColor = self.customBackgroundColor }
    }
    
    var borderColor: UIColor = .black {
        didSet { self.fieldContainer.layer.borderColor = self.borderColor.cgColor }
    }
    
    var borderWidth: CGFloat = 1.0 {
        didSet { self.fieldContainer.layer.borderWidth = self.borderWidth }
    }
    
    var cornerRadius: CGFloat = 8.0 {
        didSet { self.fieldContainer.layer.cornerRadius = self.cornerRadius }
    }
    
    var customTextColor: UIColor = .black {
        didSet { self.textField.textColor = self.customTextColor }
    }
    
    var customFont: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet { self.textField.font = self.customFont }
    }
   
    var text: String? {
        get { self.textField.text }
        set { self.textField.text = newValue }
    }
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    
    private let fieldContainer: UIView = UIView()
    private let textField: UITextField = UITextField()
    private let errorLabel: UILabel = UILabel()
    
    var placeholder: String? {
        didSet { self.textField.placeholder = self.placeholder }
    }
    
    var error: String? {
        didSet { self.updateError() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    private func updateError() {
        self.errorLabel.text = self.error
        self.errorLabel.isHidden = (self.error == nil || self.error?.isEmpty == true)
    }
    
    private func setupView() {
        self.fieldContainer.layer.borderColor = self.borderColor.cgColor
        self.fieldContainer.layer.borderWidth = self.borderWidth
        self.fieldContainer.layer.cornerRadius = self.cornerRadius
        self.fieldContainer.backgroundColor = self.customBackgroundColor
        self.fieldContainer.translatesAutoresizingMaskIntoConstraints = false

        self.textField.font = self.customFont
        self.textField.textColor = self.customTextColor
        self.textField.textAlignment = .left
        self.textField.backgroundColor = .clear
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.errorLabel.textColor = .red
        self.errorLabel.font = UIFont(name: "Arial", size: 14)
        self.errorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.errorLabel.numberOfLines = 0

        self.addSubview(fieldContainer)
        self.fieldContainer.addSubview(self.textField)
        self.addSubview(self.errorLabel)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.fieldContainer.heightAnchor.constraint(equalToConstant: 60),
            self.fieldContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: self.padding.top),
            self.fieldContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.fieldContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textField.topAnchor.constraint(equalTo: self.fieldContainer.topAnchor),
            self.textField.leadingAnchor.constraint(equalTo: self.fieldContainer.leadingAnchor, constant: self.padding.left),
            self.textField.trailingAnchor.constraint(equalTo: self.fieldContainer.trailingAnchor, constant: -self.padding.right),
            self.textField.bottomAnchor.constraint(equalTo: fieldContainer.bottomAnchor),
            self.errorLabel.topAnchor.constraint(equalTo: self.fieldContainer.bottomAnchor),
            self.errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.errorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
