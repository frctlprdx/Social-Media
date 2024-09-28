//
//  EditProfileViewController.swift
//  Social Media
//
//  Created by Ivan on 9/27/24.
//

import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class EditProfileViewController: ObservableObject {
    
    func getData(image: UIImage?, username: String, bio: String, profilename: String){
        if image != nil {
            let imageID = UUID().uuidString
            saveImage(imageID: imageID, image: image, username: username, bio: bio, profilename: profilename)
        } else if image == nil {
            editProfile(imageID: nil, username: username, bio: bio, profilename: profilename)
        }
    }
    
    func saveImage(imageID:String, image: UIImage?, username: String, bio: String, profilename:String ){
        let storageRef = Storage.storage().reference()
        let imageData = image!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else {
            return
        }
        let path = "Photos/\(imageID).jpg"
        let fileRef = storageRef.child(path)
        _ = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                self.editProfile(imageID: imageID, username:username , bio: bio, profilename: profilename)
            }
        }
        
    }
    
    func editProfile(imageID: String?, username: String, bio: String, profilename:String) {
        guard let UserID = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        let editDataRef = db.collection("users").document(UserID)
        
        editDataRef.updateData([
            "username": username,
            "profilename": profilename,
            "bio": bio,
            "imageid": imageID ?? ""
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
        
    }
    
    
}
