import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage



class FirebaseStorageManager {
    
    static let shared = FirebaseStorageManager()
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        // Create a unique identifier for the image, e.g., using UUID
        let uuid = UUID().uuidString
        let storageRef = Storage.storage().reference().child("images/\(uuid).jpg")
        
        // Compress the image and convert it to Data
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            completion(.failure(NSError(domain: "ImageConversion", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        // Upload the image to Firebase Storage
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                } else {
                    completion(.failure(NSError(domain: "ImageURL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image URL"])))
                }
            }
        }
    }
}
