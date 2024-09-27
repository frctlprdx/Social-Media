//
//  EditProfileView.swift
//  Social Media
//
//  Created by Ivan on 9/27/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var changedUsername: String = ""
    @State private var profileName: String = ""
    @State private var bio: String = ""
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Button {
                        
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
                    
                } label: {
                    Text("Save Profile")
                        .foregroundStyle(Color.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
            }
        }
    }
}

#Preview {
    EditProfileView()
}
