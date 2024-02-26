//
//  NetworkParser.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 19.02.2024.
//

import UIKit

class NetworkParser {
    
    internal func image(from data: Data) -> UIImage {
        var result = UIImage()
        if let image = UIImage(data: data) {
            result = image
        }
        
        return result
    }
}
