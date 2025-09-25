import Foundation

struct WalkthroughModel: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
}

struct BoatModel: Identifiable {
    let id = UUID()
    let name: String
    let pricePerHour: Double
    let reviews: Int
    let imageName: String // Asset name
}
