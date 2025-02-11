//
//  CustomTextField.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit

class CustomTextField: UIView {
    
    var customBackgroundColor: UIColor? {
        didSet { backgroundColor = customBackgroundColor }
    }
    
    var borderColor: UIColor = .black {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    
    var borderWidth: CGFloat = 1.0 {
        didSet { layer.borderWidth = borderWidth }
    }
    
    var cornerRadius: CGFloat = 8.0 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    
    var customTextColor: UIColor = .black {
        didSet { self.textField.textColor = customTextColor }
    }
    
    var customFont: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet { self.textField.font = customFont }
    }
    
    var text: String? {
        get { self.textField.text }
        set { self.textField.text = newValue }
    }
    
    var padding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    
    private let textField: UITextField = UITextField()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .gray
        label.backgroundColor = .clear
        label.isHidden = true
        
        return label
    }()
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
            titleLabel.isHidden = titleText == nil
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    private func setupTextField() {
        self.textField.backgroundColor = customBackgroundColor
        self.textField.layer.borderColor = borderColor.cgColor
        self.textField.layer.borderWidth = borderWidth
        self.textField.layer.cornerRadius = cornerRadius
        self.textField.textColor = customTextColor
        self.textField.font = customFont
        self.textField.textAlignment = .left
        self.addSubview(titleLabel)
        self.addSubview(textField)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50),
            self.titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.textField.topAnchor, constant: 0),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 100),
            self.textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
