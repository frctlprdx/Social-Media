//
//  ContentView.swift
//  Social Media
//
//  Created by Ivan on 02/09/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        if viewModel.isAuthenticated {
            MainView()
        } else {
            signup
        }
    }
    
    var signup: some View {
        NavigationView {
            VStack{
                Image("yourgram")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                TextField("Email", text: $email)
                    .padding([.leading,.trailing], 30)
                    .padding(.bottom, 20)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                
                SecureField("Password", text: $password)
                    .padding([.leading,.trailing], 30)
                    .padding(.bottom, 20)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                
                Button {
                    viewModel.signUp(email: email, password: password)
                } label: {
                    Text("Sign Up")
                }.padding()
                    .padding([.leading, .trailing], 100)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
                
                NavigationLink {
                    LoginView()
                } label: {
                    Text("Already Have Account ?")
                }.padding(.top, 20)
            }
        }

    }
}

#Preview {
    ContentView()
}


