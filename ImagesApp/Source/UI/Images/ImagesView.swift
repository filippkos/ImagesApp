//
//  ImagesView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit
import RxCocoa
import RxSwift

final class ImagesView: BaseView<ImagesViewModel, ImagesViewModelOutputEvent>, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: -
    // MARK: Variables

    private var collectionView = UICollectionView(frame: .null, collectionViewLayout: UICollectionViewLayout())
    private var selectedItemName: String?
    
    // MARK: -
    // MARK: Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.prepareView()
        self.prepareNavigationBar()
    }
    
    // MARK: -
    // MARK: Private
    
    override func prepareBindings(bag: DisposeBag) {
        self.viewModel.viewInputEvent
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in self?.handleInput(event: $0) }
            .disposed(by: bag)
    }
    
    private func handleInput(event: ImagesViewInputEvent) {
        switch event {
        case .reloadCollection:
            self.collectionView.reloadData()
        }
    }
    
    private func prepareNavigationBar() {
        let addPhotoItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(self.showPicker(_:))
        )
        addPhotoItem.tintColor = .black
        let deletePhotoItem = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .done,
            target: self,
            action: #selector(self.deleteImage(_:))
        )
        deletePhotoItem.tintColor = .black
        
        self.navigationItem.setRightBarButtonItems([addPhotoItem, deletePhotoItem], animated: true)
    }
    
    @objc private func showPicker(_ sender: UITapGestureRecognizer?) {
        ImagePickerManager().pickImage(self, { image in
            
            self.viewModel.loadImage(image: image)
        })
    }
    
    @objc private func deleteImage(_ sender: UITapGestureRecognizer?) {
        guard let name = self.selectedItemName else { return }
        self.viewModel.deleteImage(name: name)
    }
    
    private func prepareView() {
        self.view.backgroundColor = .green
        self.collectionView.backgroundColor = .red
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.collectionView)
        self.flowLayoutConfigure()
        self.prepareConstraints()
        self.collectionView.registerDefaultCell(cellClass: ImagesViewCollectionViewCell.self)
    }
    
    private func flowLayoutConfigure() {
        let itemWidth = (self.view.frame.size.width / 3) - 12
        let itemHeight = itemWidth
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 6
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.alwaysBounceVertical = true
        
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    // MARK: -
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(cellClass: ImagesViewCollectionViewCell.self, indexPath: indexPath)
        guard let image = self.viewModel.images?[indexPath.row].image else { return cell }
        cell.configure(image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        cell.updateConfiguration(using: cell.configurationState)
        self.selectedItemName = self.viewModel.images?[indexPath.row].name
    }
}
