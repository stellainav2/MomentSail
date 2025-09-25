import SwiftUI

struct AuthLandingView: View {
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Full screen background image
                Image("boat_bg_1")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .ignoresSafeArea()
                
                // Dark overlay for better text readability
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.3), Color.black.opacity(0.7)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Logo and branding
                    VStack(spacing: 16) {
                        Image(systemName: "sailboat.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        Text("MOMENTSAIL")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .kerning(2)
                            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                    }
                    
                    Text("Welcome Aboard")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                    
                    Text("Sign in or create an account to start booking and managing your boats.")
                        .font(.system(size: 17))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Buttons with glassmorphism effect
                    VStack(spacing: 16) {
                        Button(action: {
                            auth.activeSheet = .register
                        }) {
                            HStack {
                                Image(systemName: "person.badge.plus")
                                Text("Sign Up")
                            }
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        }
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        Button(action: {
                            auth.activeSheet = .login
                        }) {
                            HStack {
                                Image(systemName: "person.circle")
                                Text("Already have an account? Log In")
                            }
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(Color.white.opacity(0.1))
                                            .blur(radius: 0.5)
                                    )
                            )
                        }
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal, 40) // This ensures the margins are applied
                    
                    Spacer()
                }
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
