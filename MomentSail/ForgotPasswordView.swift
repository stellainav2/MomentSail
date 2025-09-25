import SwiftUI

struct ForgotPasswordView: View {
    @State private var email = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Forgot Password")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Reset your password details")
                        .foregroundColor(.white.opacity(0.8))
                    TextField("E-mail", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                    Button("Continue") {
                        // Send reset email mock
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ForgotPasswordView()
}
