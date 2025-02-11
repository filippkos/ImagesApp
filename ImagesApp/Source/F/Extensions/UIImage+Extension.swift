//
//  UIImage+Extension.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 30.01.2025.
//

import UIKit

extension UIImage {
    func croppedToSquare() -> UIImage? {
        let originalWidth = self.size.width
        let originalHeight = self.size.height
        
        let squareSize = min(originalWidth, originalHeight)
        
        let xOffset = (originalWidth - squareSize) / 2.0
        let yOffset = (originalHeight - squareSize) / 2.0
        
        let cropRect = CGRect(x: xOffset, y: yOffset, width: squareSize, height: squareSize)
        
        guard let cgImage = self.cgImage?.cropping(to: cropRect) else {
            return nil
        }
        
        return UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation)
    }
}
