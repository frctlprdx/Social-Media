//
//  PostView.swift
//  Social Media
//
//  Created by Ivan on 05/09/24.
//

import SwiftUI
import PhotosUI

struct PostView: View {
    @State private var selectedImage: UIImage?
    @State private var selectedVideo: URL?
    @State private var caption: String = ""
    @State private var isPickerPresented = false
    @State private var selectedItem: PhotosPickerItem? = nil
    
    @ObservedObject var postViewModel = PostViewController()
    
    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
            } else {
                Button(action: {
                    isPickerPresented = true
                }) {
                    VStack {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .background(Color.gray.opacity(0.8))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top)
            }
            
            
            TextField("Enter caption...", text: $caption)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.trailing, .leading], 30)
            
            Spacer()
            
            Button(action: {
                if let selectedImage = selectedImage {
                    postViewModel.uploadPost(image: selectedImage, video: nil, caption: caption)
                } else if let selectedVideo = selectedVideo {
                    postViewModel.uploadPost(image: nil, video: selectedVideo, caption: caption)
                } else {
                    Text("Pick Some Image/Videos")
                }
            }) {
                Text("Upload")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(selectedImage == nil || caption.isEmpty) // Disable button if no image or caption is empty
            .padding()
            
        }.sheet(isPresented: $isPickerPresented, onDismiss: nil, content: {
            PickImage(selectedImage: $selectedImage, isPickerShowing: $isPickerPresented)
        })
    }
}

#Preview {
    PostView()
}

