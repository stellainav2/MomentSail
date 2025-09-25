import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var auth: AuthViewModel
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        print("Rendering MainContentView, hasSeenOnboarding: \(hasSeenOnboarding), isAuthenticated: \(auth.isAuthenticated)")
        return Group {
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
    }
}

#Preview {
    MainContentView()
        .environmentObject(AuthViewModel())
}
