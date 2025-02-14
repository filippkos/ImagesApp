//
//  CustomTextField.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit

class CustomTextField: UIView {
    
    var customBackgroundColor: UIColor? {
        didSet { backgroundColor = self.customBackgroundColor }
    }
    
    var borderColor: UIColor = .black {
        didSet { layer.borderColor = self.borderColor.cgColor }
    }
    
    var borderWidth: CGFloat = 1.0 {
        didSet { layer.borderWidth = self.borderWidth }
    }
    
    var cornerRadius: CGFloat = 8.0 {
        didSet { layer.cornerRadius = self.cornerRadius }
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
    
    private let textField: UITextField = UITextField()
    
    var placeholder: String? {
        didSet { self.textField.placeholder = self.placeholder }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupView()
    }
    
    private func setupView() {
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.cornerRadius
        self.backgroundColor = self.customBackgroundColor

        self.textField.font = self.customFont
        self.textField.textColor = self.customTextColor
        self.textField.textAlignment = .left
        self.textField.backgroundColor = .clear
        self.textField.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.textField)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 60),
            
            self.textField.topAnchor.constraint(equalTo: self.topAnchor, constant: self.padding.top),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.padding.left),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.padding.right),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.padding.bottom)
        ])
    }
}
