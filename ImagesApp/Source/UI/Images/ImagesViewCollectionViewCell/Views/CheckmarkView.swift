//
//  CheckmarkView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 26.02.2024.
//

import UIKit

final class CheckmarkView: UIView {
    
    private var checkmark = UIImageView()
    private var background = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        self.prepareView()
    }
    
    private func prepareView() {
        self.addSubview(self.background)
        self.addSubview(self.checkmark)
        self.background.image = UIImage(systemName: "circle.fill")
        self.checkmark.image = UIImage(systemName: "checkmark.circle")
        self.background.tintColor = .systemBlue
        self.checkmark.tintColor = .white
        self.background.translatesAutoresizingMaskIntoConstraints = false
        self.checkmark.translatesAutoresizingMaskIntoConstraints = false
        self.prepareConstraints()
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.background.topAnchor.constraint(equalTo: self.topAnchor),
            self.background.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.background.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.checkmark.topAnchor.constraint(equalTo: self.topAnchor),
            self.checkmark.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.checkmark.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.checkmark.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
