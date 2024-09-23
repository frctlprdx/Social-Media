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
    @State private var username = ""
    
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
                
                TextField("Username", text: $username)
                    .padding([.leading,.trailing], 30)
                    .padding(.bottom, 20)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                TextField("Email", text: $email)
                    .padding([.leading,.trailing], 30)
                    .padding(.bottom, 20)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $password)
                    .padding([.leading,.trailing], 30)
                    .padding(.bottom, 20)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                
                Button {
                    viewModel.signUp(email: email,username: username, password: password)
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


