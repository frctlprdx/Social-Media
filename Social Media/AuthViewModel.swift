//
//  AuthViewModel.swift
//  Social Media
//
//  Created by Ivan on 02/09/24.
//

import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated: Bool = false
    
    init(){
        self.isAuthenticated = Auth.auth().currentUser != nil
    }
    
    func signUp(email: String, username: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isAuthenticated = false
            } else {
                self.isAuthenticated = true
                self.saveUsername(username: username, email: email)
            }
        }
    }
    
    func saveUsername(username: String, email: String){
        guard let userID = Auth.auth().currentUser?.uid else {
                self.errorMessage = "User not authenticated"
                return
            }
        let db = Firestore.firestore()
        db.collection("users").document(userID).setData([
            "username": username,
            "email": email
        ])
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
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
