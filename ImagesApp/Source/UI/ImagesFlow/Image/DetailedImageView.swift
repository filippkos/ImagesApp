//
//  DetailedImageView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 23.02.2024.
//

import UIKit

final class DetailedImageView: BaseView<DetailedImageViewModel, DetailedImageViewModelOutputEvent> {
    
    // MARK: -
    // MARK: Variables
    
    let imageView = UIImageView()
    let stackView = UIStackView()
    let square = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
    }
    
    private func prepareView() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.square.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.square.backgroundColor = .red
        self.stackView.backgroundColor = .orange
        self.view.backgroundColor = .white

        self.stackView.axis = .vertical
        
        self.view.addSubview(self.stackView)

        self.stackView.addArrangedSubview(self.imageView)
        self.stackView.addArrangedSubview(self.square)

        self.stackView.distribution = .fillProportionally
        self.prepareConstraints()
    }
    
    func configure(with image: UIImage) {
        self.imageView.image = image
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.imageView.heightAnchor.constraint(equalTo: self.view.widthAnchor),
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.square.topAnchor),
            self.square.widthAnchor.constraint(equalToConstant: 100),
            self.square.heightAnchor.constraint(equalToConstant: 100),
            self.square.rightAnchor.constraint(equalTo: self.stackView.rightAnchor)
        ])
    }
}
