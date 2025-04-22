//
//  NotificationsViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 20.04.2025.
//

import UserNotifications

enum NotificationsViewModelOutputEvent: ViewModelEvent {
    
}

final class NotificationsViewModel: BaseViewModel<NotificationsViewModelOutputEvent> {
    var notifications: [AppNotification] = []
    
    func addNotification(_ notification: AppNotification) {
        notifications.append(notification)
    }
}
