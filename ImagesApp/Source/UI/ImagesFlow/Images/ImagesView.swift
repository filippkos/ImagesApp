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
    private var selectedItemNames: Set<String> = Set<String>()
    private var isSelectionEnabled = false
    
    // MARK: -
    // MARK: Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.prepareView()
        self.prepareNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.deselectAllCells()
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
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        let selectButton = UIButton(configuration: configuration)
        selectButton.setTitle("Select", for: .normal)
        selectButton.tintColor = UIColor(named: "Colors/surface/primary")
        selectButton.addTarget(self, action: #selector(toggleSelectionMode), for: .touchUpInside)
        selectButton.frame.size.width = 100
        self.navigationItem.setRightBarButtonItems([addPhotoItem, deletePhotoItem, selectButton.toBarButtonItem()], animated: true)
    }
    
    private func prepareView() {
        self.collectionView.backgroundColor = .white
        self.collectionView.allowsMultipleSelection = true
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
    
    private func deselectAllCells() {
        guard let indexPaths = self.collectionView.indexPathsForSelectedItems else { return }
        
        for indexPath in indexPaths {
            self.collectionView.deselectItem(at: indexPath, animated: false)
        }
    }
    
    @objc private func toggleSelectionMode() {
        self.isSelectionEnabled.toggle()
        self.collectionView.allowsMultipleSelection = self.isSelectionEnabled
        
        if let selectButton = self.navigationItem.rightBarButtonItems?.last?.customView as? UIButton {
            selectButton.setTitle(self.isSelectionEnabled ? "Cancel" : "Select", for: .normal)
        }
        
        self.deselectAllCells()
    }
    
    @objc private func showPicker(_ sender: UITapGestureRecognizer?) {
        ImagePickerManager().pickImage(self, { image in
            self.viewModel.uploadImage(image: image)
        })
    }
    
    @objc private func deleteImage(_ sender: UITapGestureRecognizer?) {
        if !self.selectedItemNames.isEmpty {
            self.viewModel.deleteImages(names: self.selectedItemNames)
            self.toggleSelectionMode()
        }
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
    
    // MARK: -
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImagesViewCollectionViewCell else { return false }
        if self.isSelectionEnabled {
            guard let name = self.viewModel.images?[indexPath.row].name else { return self.isSelectionEnabled }
            self.selectedItemNames.insert(name)
        } else {
            self.viewModel.outputEvents?(.showDetailed(image: self.viewModel.images?[indexPath.row].image ?? UIImage()))
        }
        
        return self.isSelectionEnabled
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if self.isSelectionEnabled {
            guard let name = self.viewModel.images?[indexPath.row].name else { return self.isSelectionEnabled }
            self.selectedItemNames.remove(name)
        }
        return self.isSelectionEnabled
    }
}
