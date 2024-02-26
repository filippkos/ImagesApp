//
//  FirebaseStorageManager.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 18.02.2024.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseStorageManager {
    
    static let shared = FirebaseStorageManager()
    
    func getImagesList(folderName: String, completion: @escaping ([ImageModel]) -> Void) async {
        let storage = Storage.storage()
        let storageReference = storage.reference().child(folderName)
        var images: [ImageModel] = []
        
        do {
          let result = try await storageReference.listAll()
          for item in result.items {
              let image: UIImage = try await UIImage(data: item.data(maxSize: 3080*720)) ?? UIImage()
              let model = ImageModel(name: item.name, image: image)
              images.append(model)
          }
           completion(images)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func putToStorage(image: UIImage, completion: @escaping (() -> (Void))) {
        let imageName = UUID().uuidString
        let storage = Storage.storage()
        let storageReference = storage.reference().child("pictures" + "/" + imageName)
        
        //2. Compress quality
        if let uploadData = image.jpegData(compressionQuality: 0.5) {

            //3. Save image as .jpeg
            let metaDataForImage = StorageMetadata()
            metaDataForImage.contentType = "image/jpeg"

            //4. Add the data to Firebase Storage
            storageReference.putData(uploadData, metadata: metaDataForImage) { (meta, err) in
                if let err = err{
                    print(err.localizedDescription)
                } else {
                    //5. Retrieving the image URL
                    storageReference.downloadURL { (url, err) in
                        if let err = err{
                            print(err.localizedDescription)
                        }
                        else{
                            //6. Print the complete URL as string
                            let urlString = url?.absoluteString
                            print(urlString)
                            
                        }
                    }
                    completion()
                }
            }
        }
            
    }
    
    func deleteImage(with name: String) async {
        let storage = Storage.storage()
        // Create a reference to the file to delete
        let storageReference = storage.reference().child("pictures" + "/" + name)

        do {
          // Delete the file
          try await storageReference.delete()
        } catch {
          // ...
        }
    }
    
    
}
