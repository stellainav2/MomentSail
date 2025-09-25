import SwiftUI

struct AuthLandingView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Image(systemName: "sailboat.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                    Text("Welcome Aboard")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    Text("Sign in or create an account to start booking and managing your boats.")
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                    VStack(spacing: 16) {
                        Button(action: {
                            auth.activeSheet = .register
                            print("Sign Up button pressed")
                        }) {
                            Text("Sign Up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        Button(action: {
                            auth.activeSheet = .login
                            print("Log In button pressed")
                        }) {
                            Text("Already have an account? Log In")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.15))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal, 40)
                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
            .sheet(item: $auth.activeSheet) { sheet in
                switch sheet {
                case .login:
                    LogInView()
                case .register:
                    RegisterView()
                }
            }
        }
    }
}

#Preview {
    AuthLandingView()
        .environmentObject(AuthViewModel())
}
