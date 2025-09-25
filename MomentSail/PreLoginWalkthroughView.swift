import SwiftUI

struct PreLoginWalkthroughView: View {
    @EnvironmentObject var auth: AuthViewModel
    @AppStorage("hasSeenPreLogin") private var hasSeenPreLogin = false
    @State private var selection = 0

    private let pages: [WalkthroughPage] = [
        WalkthroughPage(
            title: "Discover Boats in Real-Time",
            subtitle: "Find available boats near you with live updates and instant availability.",
            imageName: "sailboat.fill"
        ),
        WalkthroughPage(
            title: "Instant Booking",
            subtitle: "Book your perfect boat in seconds with our streamlined booking process.",
            imageName: "bolt.fill"
        ),
        WalkthroughPage(
            title: "Offset Costs as Owner",
            subtitle: "List your boat and earn money when you're not using it. Turn your asset into income.",
            imageName: "creditcard.fill"
        )
    ]

    var body: some View {
        TabView(selection: $selection) {
            // 3 marketing pages
            ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                VStack(spacing: 24) {
                    Spacer()
                    Image(systemName: page.imageName)           // ✅ icon on top
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.accentColor)

                    Text(page.title)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text(page.subtitle)
                        .font(.system(size: 17))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)

                    Spacer()
                }
                .tag(index)
            }

            // 4th page = Login/Register landing
            AuthLandingView()
                .tag(pages.count)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .ignoresSafeArea()
    }
}

struct WalkthroughPage: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String
}
