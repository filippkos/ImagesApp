//
//  BarCodeScannerViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 09.04.2025.
//

import BarcodeScanner

enum BarCodeScannerViewModelOutputEvent: ViewModelEvent {
    
}

enum BarcodeScannerViewModelInputEvents {
    case reset
}

final class BarCodeScannerViewModel: BaseViewModel<BarCodeScannerViewModelOutputEvent>, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
    var code: String = ""
    
    func scannerDidDismiss(_ controller: BarcodeScanner.BarcodeScannerViewController) {
        controller.dismiss(animated: true)
    }
    
    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didReceiveError error: any Error) {
        print(error)
    }
    
    func scanner(_ controller: BarcodeScanner.BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        self.code = code
        self.notifyWith(code: code)
        
    }
    
    private func notifyWith(code: String) {
        let content = UNMutableNotificationContent()
        content.title = "Code scanned"
        content.body = "Code scanned successfully: \(code)"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        NotificationManager.shared.addNotification(
            title: content.title,
            body: content.body
        )
    }
}
