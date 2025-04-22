//
//  NotificationCollectionViewCell.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 20.04.2025.
//

//
//  ImagesViewCollectionViewCell.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Variables
    
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    
    // MARK: -
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.prepareViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public
    
    func configure(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareViews() {
        self.contentView.layer.cornerRadius = 8
        self.contentView.backgroundColor = .gray
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        self.descriptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
        self.prepareConstraints()
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.heightAnchor.constraint(equalToConstant: 32),
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor),
            self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8),
            self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8),
            
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
        ])
    }
}
