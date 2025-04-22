//
//  BarCodeScannerView.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 09.04.2025.
//

import BarcodeScanner

class BarCodeScannerView: BaseView<BarCodeScannerViewModel, BarCodeScannerViewModelOutputEvent> {
    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareView()
    }
    
    private func prepareView() {
        self.view.backgroundColor = .white
        self.prepareButton()
        self.prepareConstraints()
    }
    
    private func prepareButton() {
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        self.button = UIButton(configuration: configuration)
        self.button.setTitle("Start scanner", for: .normal)
        self.button.tintColor = UIColor(named: "Colors/surface/primary")
        self.button.addTarget(self, action: #selector(startScanner), for: .touchUpInside)
        self.button.frame.size.width = 100
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.button)
    }
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate ([
            self.button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.button.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    @objc private func startScanner() {
        self.reset()
    }
    
    private func reset() {
        let scanner = BarcodeScannerViewController()
        scanner.codeDelegate = self.viewModel
        scanner.errorDelegate = self.viewModel
        scanner.dismissalDelegate = self.viewModel
        self.navigationController?.pushViewController(scanner, animated: true)
    }
}

