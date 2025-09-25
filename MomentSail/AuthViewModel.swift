import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    // Profile data
    @Published var profileFullName = ""
    @Published var profileEmail = ""
    @Published var profilePhone = ""
    @Published var profileCity = ""
    @Published var profileCountry = ""

    private var sentCode: String? = nil
    private var currentPhone: String? = nil

    enum ActiveSheet: Identifiable {
        case login
        case register
        
        var id: String {
            switch self {
            case .login: return "login"
            case .register: return "register"
            }
        }
    }
    
    @Published var activeSheet: ActiveSheet?

    func sendOTP(to phone: String, completion: @escaping (Bool) -> Void) {
        guard !phone.isEmpty else {
            errorMessage = "Phone is empty"
            completion(false)
            return
        }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let code = String(format: "%06d", Int.random(in: 0...999_999))
            self.sentCode = code
            self.currentPhone = phone
            self.isLoading = false
            print("DEBUG: Sent OTP for \(phone): \(code)  <-- use this in OTP field for testing")
            completion(true)
        }
    }

    func verifyOTP(_ code: String) -> Bool {
        guard !isLoading else { return false }
        guard let expected = sentCode else {
            errorMessage = "No code sent"
            return false
        }
        if code == expected {
            sentCode = nil
            currentPhone = nil
            isAuthenticated = true
            errorMessage = nil
            return true
        } else {
            errorMessage = "Incorrect code"
            return false
        }
    }

    func loginWithEmail(email: String, password: String) -> Bool {
        if email.contains("@") && password.count >= 4 {
            isAuthenticated = true
            profileEmail = email // Set profile data on login
            errorMessage = nil
            return true
        } else {
            errorMessage = "Invalid email or password (mock)"
            return false
        }
    }

    func signOut() {
        isAuthenticated = false
    }
}
