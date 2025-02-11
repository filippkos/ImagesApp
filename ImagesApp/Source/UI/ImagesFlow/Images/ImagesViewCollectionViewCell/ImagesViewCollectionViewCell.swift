//
//  ImagesViewCollectionViewCell.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit

class ImagesViewCollectionViewCell: UICollectionViewCell {
    
    // MARK: -
    // MARK: Variables
    
    private var imageView = UIImageView()
    private var checkmark = CheckmarkView()
    
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
    
    func configure(image: UIImage) {
        self.imageView.image = image
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        self.checkmark.isHidden = state.isSelected == true ? false : true
    }
    
    // MARK: -
    // MARK: Private
    
    private func prepareViews() {
        self.checkmark.isHidden = true
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.checkmark)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.checkmark.translatesAutoresizingMaskIntoConstraints = false
        self.prepareConstraints()
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            
            self.checkmark.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.checkmark.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8),
            self.checkmark.heightAnchor.constraint(equalToConstant: 30),
            self.checkmark.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
