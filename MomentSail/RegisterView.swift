// ... other imports
import AuthenticationServices // Import this for Sign in with Apple

struct RegisterView: View {
    @EnvironmentObject var auth: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var agreeToTerms = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    // ... (existing code for name, email, password fields)

                    // Social Auth Buttons
                    VStack(spacing: 12) {
                        Text("Or register with")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.caption)
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                auth.loginWithGoogle()
                            }) {
                                Image("google_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(.plain)
                            
                            Button(action: {
                                auth.loginWithFacebook()
                            }) {
                                Image("facebook_icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            .buttonStyle(.plain)
                            
                            SignInWithAppleButton(
                                .continue,
                                onRequest: { request in
                                    // You need to configure this with your Apple Developer account
                                    request.requestedScopes = [.fullName, .email]
                                },
                                onCompletion: { result in
                                    switch result {
                                    case .success(let authResults):
                                        auth.loginWithApple(authorization: authResults)
                                    case .failure(let error):
                                        print("Apple Sign-In failed: \(error.localizedDescription)")
                                    }
                                }
                            )
                            .frame(width: 30, height: 30)
                            .signInWithAppleButtonStyle(.whiteOutline)
                        }
                    }
                    .padding(.top)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Sign Up")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
