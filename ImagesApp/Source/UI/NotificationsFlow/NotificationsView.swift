//
//  NotificationsView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 20.04.2025.
//

import UIKit

final class NotificationsView: BaseView<NotificationsViewModel, NotificationsViewModelOutputEvent>, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let collectionView = UICollectionView(frame: .null, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.setupNotificationHandling()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UNUserNotificationCenter.current().delegate = self
        collectionView.reloadData()
    }
    
    private func prepareView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .white
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.flowLayoutConfigure()
        self.prepareConstraints()
        self.collectionView.registerDefaultCell(cellClass: NotificationCollectionViewCell.self)
    }
    
    private func flowLayoutConfigure() {
        let itemWidth = (self.view.frame.size.width) - 12 - 64
        let itemHeight = CGFloat(100)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 6
        layout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = layout
        self.collectionView.alwaysBounceVertical = true
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate ([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -32),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 32),
        ])
    }
    
    private func setupNotificationHandling() {
        viewModel.notifications = NotificationManager.shared.getAllNotifications()
        
        NotificationManager.shared.onNewNotification = { [weak self] notification in
            self?.viewModel.notifications.append(notification)
            self?.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(cellClass: NotificationCollectionViewCell.self, indexPath: indexPath)
        let notification = viewModel.notifications[indexPath.item]
        cell.configure(
            title: notification.title,
            description: notification.body
        )
        return cell
    }
}

extension NotificationsView: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                               willPresent notification: UNNotification,
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
