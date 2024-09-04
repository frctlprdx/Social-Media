//
//  AuthViewModel.swift
//  Social Media
//
//  Created by Helena on 02/09/24.
//

import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated: Bool = false
    
    init(){
        self.isAuthenticated = Auth.auth().currentUser != nil
    }
    
    func signUp(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isAuthenticated = false
            } else {
                self.isAuthenticated = true
            }
        }
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error {
                self?.errorMessage = error.localizedDescription
                self?.isAuthenticated = false
            } else {
                self?.isAuthenticated = true
                self?.errorMessage = nil
            }
        }
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                self.isAuthenticated = false
            } catch {
                self.errorMessage = "Failed to sign out: \(error.localizedDescription)"
            }
        }
    
}
