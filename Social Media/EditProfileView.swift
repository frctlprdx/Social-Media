//
//  EditProfileView.swift
//  Social Media
//
//  Created by Ivan on 9/27/24.
//

import SwiftUI
import Combine

struct EditProfileView: View {
    @State private var changedUsername: String = ""
    @State private var profileName: String = ""
    @State private var bio: String = ""
    @State private var isPickerPresented = false
    @State private var selectedImage: UIImage?
    
    @ObservedObject var editProfileViewController = EditProfileViewController()
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    isPickerPresented = true
                } label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .foregroundStyle(Color.black)
                        .padding()
                }
            }
            
            VStack {
                
                TextField("Change Username", text: $changedUsername)
                    .padding([.top, .horizontal])
                
                TextField("Change Profile Name",text: $profileName).padding([.top, .horizontal])
                
                TextField("Change Bio", text: $bio).padding([.top, .horizontal])
            }
            
            Spacer()
            
            Button {
                if let selectedImage = selectedImage{
                    editProfileViewController.getData(image: selectedImage, username: changedUsername, bio: bio, profilename: profileName)
                }
            } label: {
                Text("Save Profile")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
        }.sheet(isPresented: $isPickerPresented, onDismiss: nil, content: {
            PickImage(selectedImage: $selectedImage, isPickerShowing: $isPickerPresented)
        })
    }
}

#Preview {
    EditProfileView()
}
