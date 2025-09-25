import SwiftUI

struct SetPasswordView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Set Password")
                        .font(.title)
                        .foregroundColor(.white)
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                    SecureField("Confirm your password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                    Button("Register") {
                        if password == confirmPassword {
                            auth.loginWithEmail(email: "user@example.com", password: password) // Mock
                            // Navigate to Congratulations
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(password != confirmPassword)
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SetPasswordView()
        .environmentObject(AuthViewModel())
}
