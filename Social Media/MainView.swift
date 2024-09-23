//
//  MainView.swift
//  Social Media
//
//  Created by Ivan on 03/09/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = AuthViewModel()
    var body: some View {
        Group{
            if viewModel.isAuthenticated {
                feeds
            } else {
                ContentView()
            }
        }
    }
    
    var feeds: some View {
        NavigationView{
            VStack{
                //menu atas
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "exclamationmark.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                            .padding(5)
                    }

                    Spacer()
                    
                    Text("YourGram")
                        .font(.title)
                        .bold()
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.black)
                            .padding(5)
                    }

                    
                }
                .padding()
                .background(Color.white)
                .shadow(color: .gray, radius: 1, x: 0, y: 1)
                
                Spacer()
                
                HStack{
                    //scrollview
                    
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
    MainView()
}

