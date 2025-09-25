//
//  AuthViewModel.swift
//  MomentSail
//
//  Created by Apple on 04/09/2024.
//
import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import AuthenticationServices
import CoreLocation

// Define a simple enum for active sheet
enum ActiveSheet: Identifiable {
    case login
    case register
    
    var id: Int {
        hashValue
    }
}

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var activeSheet: ActiveSheet?
    @Published var profileEmail: String?
    @Published var verificationID: String?
    
    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.isAuthenticated = user != nil
            if let user = user {
                self.profileEmail = user.email
            } else {
                self.profileEmail = nil
            }
        }
    }
    
    // MARK: - Email Authentication
    func loginWithEmail(email: String, password: String) -> Bool {
        isLoading = true
        var success = false
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = nil
                self.isAuthenticated = true
                success = true
            }
        }
        return success
    }
    
    func registerUser(email: String, password: String) -> Bool {
        isLoading = true
        var success = false
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = nil
                self.isAuthenticated = true
                success = true
            }
        }
        return success
    }
    
    // MARK: - Phone Authentication (OTP)
    func sendOTP(to phone: String, completion: @escaping (Bool) -> Void) {
        isLoading = true
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil) { [weak self] verificationID, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                self.verificationID = verificationID
                print("DEBUG: Sent OTP for \(phone): \(verificationID ?? "No ID") <-- use this in OTP field for testing")
                completion(true)
            }
        }
    }
    
    func verifyOTP(code: String, completion: @escaping (Bool) -> Void) {
        guard let verificationID = verificationID else {
            errorMessage = "Verification ID not found"
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        isLoading = true
        Auth.auth().signIn(with: credential) { [weak self] _, error in
            guard let self = self else { return }
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                self.errorMessage = nil
                self.isAuthenticated = true
                completion(true)
            }
        }
    }
    
    // MARK: - Social Authentication
    func loginWithGoogle() {
        // Mock success for now
        self.isAuthenticated = true
        self.errorMessage = nil
        print("Google login successful (mock)")
    }
    
    func loginWithFacebook() {
        // Mock success for now
        self.isAuthenticated = true
        self.errorMessage = nil
        print("Facebook login successful (mock)")
    }
    
    func loginWithApple(authorization: ASAuthorization) {
        // Mock success for now
        self.isAuthenticated = true
        self.errorMessage = nil
        print("Apple login successful (mock)")
    }
    
    // MARK: - Sign Out
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.isAuthenticated = false
            self.profileEmail = nil
            self.errorMessage = nil
        } catch let signOutError as NSError {
            self.errorMessage = signOutError.localizedDescription
            print("Error signing out: %@", signOutError)
        }
    }
}
