import SwiftUI

struct LogInView: View {
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var showOTPView = false
    @State private var savedPhoneNumber = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background to match AuthLandingView
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        Spacer().frame(height: 50)
                        
                        // Header
                        Text("Welcome Back")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                        
                        Text("Log in to your account to continue your journey.")
                            .font(.system(size: 17))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        
                        // Email and password section
                        VStack(spacing: 16) {
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .colorScheme(.dark) // Ensures keyboard is dark
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .colorScheme(.dark)
                            
                            Button("Login with Email") {
                                if auth.loginWithEmail(email: email, password: password) {
                                    auth.activeSheet = nil
                                    auth.profileEmail = email
                                    print("Email login successful")
                                } else {
                                    auth.errorMessage = "Invalid email or password"
                                    print("Email login failed: \(auth.errorMessage ?? "No error")")
                                }
                            }
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            if let error = auth.errorMessage {
                                Text(error)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Divider
                        HStack {
                            VStack { Divider().background(Color.white.opacity(0.3)) }
                            Text("or").foregroundColor(.white.opacity(0.7))
                            VStack { Divider().background(Color.white.opacity(0.3)) }
                        }
                        .padding(.horizontal)
                        
                        // Social Login Buttons
                        VStack(spacing: 16) {
                            Button(action: {
                                auth.loginWithGoogle()
                            }) {
                                HStack {
                                    Image("google_icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    Text("Sign in with Google")
                                }
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                            }
                            
                            // Add other social login buttons here like Facebook, Apple, etc.
                        }
                        .padding(.horizontal)
                        
                        // Link to sign up
                        Button("Don't have an account? Sign Up") {
                            auth.activeSheet = .register
                        }
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    }
                    .padding()
                }
                .navigationTitle("Log In")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
