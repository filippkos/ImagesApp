//
//  NotificationManager.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 21.04.2025.
//

import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}
    
    private var notifications: [AppNotification] = []
    var onNewNotification: ((AppNotification) -> Void)?
    
    func addNotification(title: String, body: String) {
        let newNotification = AppNotification(
            id: UUID().uuidString,
            title: title,
            body: body
        )
        notifications.append(newNotification)
        onNewNotification?(newNotification)
    }
    
    func getAllNotifications() -> [AppNotification] {
        return notifications
    }
}
