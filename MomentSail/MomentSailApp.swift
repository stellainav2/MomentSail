import SwiftUI

struct MomentSailApp: App {
    @StateObject private var auth = AuthViewModel()
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some Scene {
        WindowGroup {
            Group {
                if !hasSeenOnboarding {
                    OnboardingView()
                        .onAppear {
                            print("OnboardingView appeared, state: hasSeenOnboarding=\(hasSeenOnboarding), isAuthenticated=\(auth.isAuthenticated)")
                        }
                } else if !auth.isAuthenticated {
                    AuthLandingView()
                        .onAppear {
                            print("AuthLandingView appeared, state: hasSeenOnboarding=\(hasSeenOnboarding), isAuthenticated=\(auth.isAuthenticated)")
                        }
                } else {
                    NavigationStack {
                        HomeView()
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(destination: ProfileView()) {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .onAppear {
                                print("HomeView appeared, state: hasSeenOnboarding=\(hasSeenOnboarding), isAuthenticated=\(auth.isAuthenticated)")
                            }
                    }
                }
            }
            .environmentObject(auth)
            .preferredColorScheme(.dark)
            .onAppear {
                print("App launched, auth.isAuthenticated: \(auth.isAuthenticated), hasSeenOnboarding: \(hasSeenOnboarding)")
                // Reset both states to force OnboardingView
                DispatchQueue.main.async {
                    auth.isAuthenticated = false
                    UserDefaults.standard.set(false, forKey: "hasSeenOnboarding")
                }
            }
        }
    }
}
