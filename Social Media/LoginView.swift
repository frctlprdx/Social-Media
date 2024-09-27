//
//  LoginView.swift
//  Social Media
//
//  Created by Ivan on 02/09/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = AuthViewController()
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        if viewModel.isAuthenticated {
            MainView()
        } else {
            signin
        }
    }
    
    var signin: some View {
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
                    viewModel.signIn(email: email, password: password)
                } label: {
                    Text("Sign In")
                }.padding()
                    .padding([.leading, .trailing], 100)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
                
                if let errorMessage = viewModel.errorMessage{
                    Text(errorMessage)
                        .padding()
                        .foregroundColor(.red)
                        .background(Color.red.opacity(0.6))
                        .cornerRadius(10)
                }
                
            }
        }
    }
}
