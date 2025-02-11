//
//  ServiceContainer.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 11.02.2025.
//

import Foundation

public final class ServiceContainer {

    public static let shared = ServiceContainer()
    public weak var logoutDelegate: LogoutDelegate?
}
