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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
        self.prepareConstraints()
    }
    
    private func prepareView() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.view.backgroundColor = .white
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.imageView)
        self.imageView.contentMode = .scaleAspectFit
    }
    
    func configure(with image: UIImage) {
        self.imageView.image = image
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
