//
//  ProfileView.swift
//  Social Media
//
//  Created by Ivan on 9/23/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = AuthViewModel()
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .padding(.trailing)
                    
                    VStack(alignment: .center) {
                        Text("20")
                            .font(.headline)
                        Text("Posts")
                            .font(.caption)
                    }
                    Spacer()
                    VStack(alignment: .center) {
                        Text("1.5k")
                            .font(.headline)
                        Text("Followers")
                            .font(.caption)
                    }
                    Spacer()
                    VStack(alignment: .center) {
                        Text("300")
                            .font(.headline)
                        Text("Following")
                            .font(.caption)
                    }
                }
                .padding()
                
                HStack {
                    Text("Username")
                }
                .padding(.leading)
                
                HStack {
                    Text("Bio")
                }
                .padding(.leading)
                
                HStack{
                    Spacer()
                    NavigationLink {
                        
                    } label: {
                        Text("Edit Profile")
                            .frame(maxWidth: 250)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
                Divider().background(Color.black)
                Spacer()
                
                HStack{
                    
                }
                
                HStack {
                    Spacer()
                    NavigationLink {
                        MainView()
                    } label: {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        PostView()
                    } label: {
                        Image(systemName: "plus.app")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                    
                    Spacer()
                    
                }.padding()
                    .background(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: -1)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileView()
}
