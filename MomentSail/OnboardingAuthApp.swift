import SwiftUI

@main
struct OnboardingAuthApp: App {
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
                            .onAppear {
                                print("HomeView appeared, state: hasSeenOnboarding=\(hasSeenOnboarding), isAuthenticated=\(auth.isAuthenticated)")
                            }
                    }
                }
            }
            .environmentObject(auth)
            .onAppear {
                print("App launched, auth.isAuthenticated: \(auth.isAuthenticated)")
                DispatchQueue.main.async {
                    auth.isAuthenticated = false
                    UserDefaults.standard.set(false, forKey: "hasSeenOnboarding")
                }
            }
        }
    }
}
