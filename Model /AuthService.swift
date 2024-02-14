//
//  AuthService.swift
//  My Wallet App
//
//  Created by Moha Maanka on 1/13/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


enum AuthState {
    case undefined
    case authenticated
    case notauthenticated
}
class AuthService: ObservableObject {
    
    @Published var profile = UserProfile()
    @Published var authState: AuthState = .undefined
    @Published var uid: String = ""
    
    
    init(){
        setupAuthListener()
    }
    
    
    func setupAuthListener() {
        Auth.auth().addStateDidChangeListener { _, user in
            DispatchQueue.main.async { // Ensure UI updates are on the main thread
                self.authState = user == nil ? .notauthenticated : .authenticated
                guard let user = user else { return }
                self.uid = user.uid
            }
        }
    }
    
    
    
    func signUp(_ email: String , password: String , name : String) async throws {
        guard name != "" else {return}
        try await Auth.auth().createUser(withEmail: email, password: password)
        guard uid != "" else {return}
        try createProfile(name: name)
        
    }
    
    func createProfile(name : String) throws {
        let reference = Firestore.firestore().collection("UserProfile").document(uid)
        let profile = UserProfile(name: name)
        try reference.setData(from: profile)
    }
    
    
    func login(_ email: String , password : String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    func fetchProfile() async throws {
        let reference = Firestore.firestore().collection("UserProfile").document(uid)
        let profile = try await reference.getDocument(as: UserProfile.self)
        DispatchQueue.main.async { // Ensure UI updates are on the main thread
            self.profile = profile
        }
    }
    
}
