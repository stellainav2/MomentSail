import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = true
    @State private var selection = 0
    @EnvironmentObject var auth: AuthViewModel

    private let pages: [WalkthroughModel] = [
        WalkthroughModel(title: "Discover boats in real-time", subtitle: "Find available boats near you with live updates and instant availability.", icon: "location.circle.fill"),
        WalkthroughModel(title: "Instant Booking", subtitle: "Book your perfect boat in seconds with our streamlined booking process.", icon: "clock.fill"),
        WalkthroughModel(title: "Offset costs as owner", subtitle: "List your boat and earn money when you're not using it. Turn your asset into income.", icon: "dollarsign.circle.fill")
    ]

    var body: some View {
        TabView(selection: $selection) {
            ForEach(pages.indices, id: \.self) { index in
                let page = pages[index]
                ZStack {
                    // Background image or gradient for Figma style
                    LinearGradient(gradient: Gradient(colors: [.black, .gray.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Spacer()
                        Image(systemName: page.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130, height: 130)
                            .foregroundColor(.white)
                        Text(page.title)
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Text(page.subtitle)
                            .font(.system(size: 17))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding()
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .animation(.easeInOut, value: selection)

        VStack {
            HStack {
                if selection < pages.count - 1 {
                    Button("Skip") {
                        hasSeenOnboarding = true
                    }
                    .foregroundColor(.white)
                    Spacer()
                    Button("Next") {
                        withAnimation { selection += 1 }
                    }
                    .foregroundColor(.blue)
                } else {
                    Button("Get Started") {
                        hasSeenOnboarding = true
                        auth.activeSheet = .register
                    }
                    .bold()
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 1))
                    .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AuthViewModel())
}
