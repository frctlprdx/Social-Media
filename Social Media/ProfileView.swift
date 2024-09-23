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
                    VStack{
                        Button {
                            viewModel.signOut()
                        } label: {
                            Text("Try Sign Out")
                        }
                        
                        NavigationLink{
                            PostView()
                        }label: {
                            Text("Go To PostView")
                        }

                    }
                }.navigationBarBackButtonHidden(true)
    }
}
