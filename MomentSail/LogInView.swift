import SwiftUI

struct LogInView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var phone = ""
    @State private var showOTPView = false
    @State private var savedPhoneNumber = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Email login")) {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
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
                }
                Section(header: Text("Phone (OTP)")) {
                    TextField("Phone e.g. +1234567890", text: $phone)
                        .keyboardType(.phonePad)
                    Button(action: {
                        auth.sendOTP(to: phone) { ok in
                            if ok {
                                savedPhoneNumber = phone
                                showOTPView = true
                            } else if let error = auth.errorMessage {
                                print("OTP send failed: \(error)")
                            }
                        }
                    }) {
                        HStack {
                            if auth.isLoading { ProgressView().scaleEffect(0.8) }
                            Text("Send OTP")
                        }
                    }
                    .disabled(phone.isEmpty || auth.isLoading)
                    if showOTPView {
                        NavigationLink(destination: OTPVerificationView(phone: savedPhoneNumber)) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                }
                if let error = auth.errorMessage {
                    Section {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LogInView()
        .environmentObject(AuthViewModel())
}
