import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var selection = 0
    @EnvironmentObject var auth: AuthViewModel

    private let pages: [WalkthroughModel] = [
        WalkthroughModel(
            title: "Discover boats in real-time",
            subtitle: "Find available boats near you with live updates and instant availability.",
            icon: "location.circle.fill"
        ),
        WalkthroughModel(
            title: "Instant Booking",
            subtitle: "Book your perfect boat in seconds with our streamlined booking process.",
            icon: "clock.fill"
        ),
        WalkthroughModel(
            title: "Offset costs as owner",
            subtitle: "List your boat and earn money when you're not using it. Turn your asset into income.",
            icon: "dollarsign.circle.fill"
        )
    ]

    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                ForEach(pages.indices, id: \.self) { index in
                    let page = pages[index]
                    ZStack {
                        // Full screen background image
                        Image("boat_bg_\(index + 1)")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                            .ignoresSafeArea()

                        // Gradient overlay
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.3),
                                Color.black.opacity(0.7)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()

                        VStack(spacing: 30) {
                            Spacer()

                            // Icon with glow effect
                            Image(systemName: page.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .shadow(color: .blue.opacity(0.5), radius: 20, x: 0, y: 0)
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)

                            VStack(spacing: 16) {
                                Text(page.title)
                                    .font(.system(size: 34, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)

                                Text(page.subtitle)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white.opacity(0.9))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30) // Adds horizontal margins
                                    .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 1)
                            }
                            Spacer()
                        }
                        .padding() // Adds overall padding
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            // Bottom navigation
            VStack {
                Spacer()
                HStack {
                    if selection < pages.count - 1 {
                        Button("Skip") {
                            hasSeenOnboarding = true
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        Spacer()
                        Button("Next") {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                selection += 1
                            }
                        }
                        .foregroundColor(.blue)
                        .font(.system(size: 16, weight: .semibold))
                    } else {
                        Spacer()
                        Button("Get Started") {
                            hasSeenOnboarding = true
                        }
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 15)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        Spacer()
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
    }
}
