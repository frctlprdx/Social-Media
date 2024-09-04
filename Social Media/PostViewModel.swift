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
    @Published var isUploading = false
    @Published var errorMessage: String?
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    func uploadPost(image: UIImage?, videoURL: URL?, caption: String){
        guard let userID = Auth.auth().currentUser?.uid else {
            self.errorMessage = "User not Authenticated"
            return
        }
        
        isUploading = true
        let postID = UUID().uuidString
        let timestamp = Timestamp(date: Date())
        
        if let image = image {
            uploadImage(image: image, postID:postID , userID: userID, caption: caption, timestamp: timestamp)
        }
        
        if let videoURL = videoURL {
            uploadVideo(video: videoURL, postID: postID, userID: userID, caption: caption, timestamp: timestamp)
        }
    }
    
    func uploadImage(image: UIImage, postID: String, userID: String, caption: String, timestamp: Timestamp) {
        let imageRef = storage.reference().child("images/\(postID).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            self.errorMessage = "Failed to convert image to data"
            self.isUploading = false
            return
        }

        imageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            if let error = error {
                self?.errorMessage = "Image upload failed: \(error.localizedDescription)"
                self?.isUploading = false
                return
            }

            imageRef.downloadURL { [weak self] url, error in
                if let error = error {
                    self?.errorMessage = "Failed to get image URL: \(error.localizedDescription)"
                    self?.isUploading = false
                    return
                }

                self?.savePost(imageURL: url?.absoluteString, videoURL: nil, postID: postID, userID: userID, caption: caption, timestamp: timestamp)
            }
        }
    }

    
    func uploadVideo(video: URL, postID: String, userID: String, caption: String, timestamp: Timestamp) {
        let videoRef = storage.reference().child("videos/\(postID).mp4")

        videoRef.putFile(from: video, metadata: nil) { [weak self] _, error in
            if let error = error {
                self?.errorMessage = "Video upload failed: \(error.localizedDescription)"
                self?.isUploading = false
                return
            }

            videoRef.downloadURL { [weak self] url, error in
                if let error = error {
                    self?.errorMessage = "Failed to get video URL: \(error.localizedDescription)"
                    self?.isUploading = false
                    return
                }

                self?.savePost(imageURL: nil, videoURL: url?.absoluteString, postID: postID, userID: userID, caption: caption, timestamp: timestamp)
            }
        }
    }
    
    private func savePost(imageURL: String?, videoURL: String?, postID: String, userID: String, caption: String, timestamp: Timestamp) {
        let postData: [String: Any] = [
            "imageURL": imageURL ?? "",
            "videoURL": videoURL ?? "",
            "caption": caption,
            "timestamp": timestamp
        ]

        db.collection("users").document(userID).collection("posts").document(postID).setData(postData) { [weak self] error in
            if let error = error {
                self?.errorMessage = "Error writing post to Firestore: \(error.localizedDescription)"
            } else {
                print("Post successfully saved!")
            }
            self?.isUploading = false
        }
    }



    
}
