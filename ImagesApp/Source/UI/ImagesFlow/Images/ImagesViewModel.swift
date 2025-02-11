//
//  ImagesViewModel.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 17.02.2024.
//

import UIKit
import RxCocoa

enum ImagesViewModelOutputEvent: ViewModelEvent {
    case showDetailed(image: UIImage)
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
            do {
                try await FirebaseStorageManager.shared.getImagesList(folderName: "pictures", completion: { images in
                    self.images = images
                })
                self.viewInputEvent.accept(.reloadCollection)
            } catch {
                print("Error fetching images: \(error)")
            }
        }
    }
    
    func uploadImage(image: UIImage) {
        FirebaseStorageManager.shared.putToStorage(image: image, completion: {
            self.loadImages()
        })
    }
    
    func deleteImage(name: String) {
        Task {
            do {
                try await FirebaseStorageManager.shared.deleteImage(with: name)
                self.loadImages()
            } catch {
                print("Error fetching images: \(error)")
            }
        }
    }
    
    func openDetailedImage() {
        
    }
}
