//
//  ImagesViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit
import RxCocoa

enum ImagesViewModelOutputEvent: ViewModelEvent {
    
}

enum ImagesViewInputEvent {
    case reloadCollection
}

final class ImagesViewModel: BaseViewModel<ImagesViewModelOutputEvent> {
    
    var images: [ImageModel]?
    var viewInputEvent = PublishRelay<ImagesViewInputEvent>()
    
    override init() {
        super.init()
        
        self.loadImages()
    }
    
    func loadImages() {
        Task {
            try await FirebaseStorageManager.shared.getImagesList(folderName: "pictures", completion:{ images in
                self.images = images
            })
            
            self.viewInputEvent.accept(.reloadCollection)
        }
    }
    
    func loadImage(image: UIImage) {
        FirebaseStorageManager.shared.putToStorage(image: image, completion: {
            self.loadImages()
        })
    }
    
    func deleteImage(name: String) {
        Task {
            try await FirebaseStorageManager.shared.deleteImage(with: name)
            self.loadImages()
        }
    }
    
    func openDetailedImage() {
        
    }
}

