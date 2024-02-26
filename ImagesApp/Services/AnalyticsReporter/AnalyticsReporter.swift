//
//  AnalyticsReporter.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 26.02.2024.
//

import Foundation
import FirebaseAnalytics

protocol AnalyticsReporter {
    
    func reportEvent(with message: String, parameters: [String: Any]?)
}

class AnalyticsReporterImplementation: AnalyticsReporter {
    
    func reportEvent(with message: String, parameters: [String : Any]?) {
        Analytics.logEvent(message, parameters: parameters)
    }
}
