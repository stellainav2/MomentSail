import SwiftUI

struct OTPVerificationView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var otp = ""
    let phone: String // Added as a let to store the passed phone number

    // Computed property to get individual digit bindings
    private func digitBinding(at index: Int) -> Binding<String> {
        Binding(
            get: {
                if otp.utf8.count > index {
                    String(otp.utf8[otp.utf8.index(otp.utf8.startIndex, offsetBy: index)])
                } else {
                    ""
                }
            },
            set: { newValue in
                guard index < 6 else { return } // Ensure index is within bounds
                if let startIndex = otp.utf8.index(otp.utf8.startIndex, offsetBy: index, limitedBy: otp.utf8.endIndex) {
                    let endIndex = otp.utf8.index(startIndex, offsetBy: 1, limitedBy: otp.utf8.endIndex) ?? otp.utf8.endIndex
                    let range = startIndex..<endIndex
                    // Use empty string as default for optional String conversions
                    var newOTP = (String(otp.utf8.prefix(upTo: startIndex)) ?? "") + newValue + (String(otp.utf8.suffix(from: range.upperBound)) ?? "")
                    newOTP = String(newOTP.utf8.prefix(6)) ?? "" // Limit to 6 digits
                    otp = newOTP
                }
            }
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Verify OTP")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Enter the 6-digit code sent to \(phone)") // Use the passed phone
                        .foregroundColor(.white.opacity(0.8))
                    HStack(spacing: 10) {
                        ForEach(0..<6) { index in
                            TextField("", text: digitBinding(at: index))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 40)
                                .multilineTextAlignment(.center)
                                .keyboardType(.numberPad)
                        }
                    }
                    Button("Verify") {
                        if auth.verifyOTP(otp) {
                            // Navigate to Set Password or Home
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(otp.count != 6)
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview("OTPVerificationView") {
    OTPVerificationView(phone: "+1 234 567 8900")
        .environmentObject(AuthViewModel())
}
