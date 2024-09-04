//
//  MainView.swift
//  Social Media
//
//  Created by Helena on 03/09/24.
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
        VStack{
            Button {
                viewModel.signOut()
            } label: {
                Text("Try Sign Out")
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainView()
}
