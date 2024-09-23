//
//  PostViewModel.swift
//  Social Media
//
//  Created by Ivan on 04/09/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class PostViewModel: ObservableObject {

    var errorMessage: String = ""
    var isUploading: Bool = false
    
    func uploadPost(image: UIImage?, video: URL?, caption: String) {
        guard let userID = Auth.auth().currentUser?.uid else {
                self.errorMessage = "User not authenticated"
                return
            }
        
        isUploading = true
            let postID = UUID().uuidString
            let timestamp = Timestamp(date: Date())
        
        if let image = image{
            imageToStorage(image: image, postID: postID, userID: userID, caption: caption, timestamp: timestamp)
        } else if let video = video{
            
        } else {
            self.errorMessage = "No Image or video provided"
            self.isUploading = false
        }
    }
    
    func imageToStorage(image: UIImage?, postID: String, userID: String, caption: String, timestamp: Timestamp){
        let storageRef = Storage.storage().reference()
        let imageData = image!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else{
            return
        }
        let path = "Photos/\(postID).jpg"
        let fileRef = storageRef.child(path)
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                self.imageToDatabase(URLimage: path, postID: postID, userID: userID, caption: caption, timestamp: timestamp)
            }
        }
    }
    
    func imageToDatabase(URLimage: String, postID: String, userID: String, caption: String, timestamp: Timestamp) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)
        userRef.getDocument { (document, error) in
                if let error = error {
                    print("Error getting document: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document, document.exists else {
                    print("Document does not exist")
                    return
                }
                
                // Mengambil data dari dokumen
                if let data = document.data(), let username = data["username"] as? String {
                    db.collection("posts").document(postID).setData([
                        "username": username,
                        "caption": caption,
                        "imageURL":URLimage,
                        "timestamp": timestamp,
                        "videoURL": ""
                    ])
                } else {
                    print("Username not found")
                }
            }
        
    }
    
}

