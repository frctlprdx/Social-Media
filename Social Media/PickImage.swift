//
//  PickImage.swift
//  Social Media
//
//  Created by Ivan on 06/09/24.
//

import Foundation
import UIKit
import SwiftUI

struct PickImage: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
    
    
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: PickImage
    init(picker: PickImage) {
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Run the code when the user has selected an image
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //We were able to get the image
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        //Dismiss the Picker
        parent.isPickerShowing = false
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Run the code when the user has cancelled the picker UI
        parent.isPickerShowing = false
    }
}
