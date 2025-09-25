import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var agreeToTerms = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Sign Up")
                        .font(.title)
                        .foregroundColor(.white)
                    TextField("Name Surname", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                    TextField("E-mail", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                    Toggle("I agree to the Terms and Privacy Policy", isOn: $agreeToTerms)
                        .foregroundColor(.white)
                        .font(.caption)
                    Button("Sign Up") {
                        if agreeToTerms {
                            auth.activeSheet = .register // Trigger OTP
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(!agreeToTerms)
                    Spacer()
                    Text("Already have an account? Log In")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            // Navigate to Log In
                        }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
