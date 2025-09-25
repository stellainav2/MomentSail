import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var phoneNumber = ""
    @State private var otp = ""
    @State private var showOTPField = false

    var body: some View {
        VStack(spacing: 20) {
            if !showOTPField {
                Text("Register with Phone")
                    .font(.title)
                TextField("Enter Phone Number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
                    .frame(width: 200)
                    .multilineTextAlignment(.center)
                Button(action: {
                    auth.sendOTP(to: phoneNumber) { success in
                        if success {
                            showOTPField = true
                        }
                    }
                }) {
                    Text("Send OTP")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(phoneNumber.isEmpty)
            } else {
                Text("Enter OTP")
                    .font(.title)
                TextField("Enter 6-digit OTP", text: $otp)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .frame(width: 200)
                    .multilineTextAlignment(.center)
                Button(action: {
                    if auth.verifyOTP(otp) {
                        auth.activeSheet = nil
                        auth.profilePhone = phoneNumber
                        print("Registration successful")
                    }
                }) {
                    Text("Verify OTP")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(otp.count != 6)
                if let error = auth.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthViewModel())
}
