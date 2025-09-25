import Foundation
import MapKit

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
    let imageURL: String
    let coordinate: CLLocationCoordinate2D
    let category: BoatCategory
    let capacity: Int
    let length: String
    let isAvailable: Bool
    let ownerName: String
    let description: String
}

enum BoatCategory: String, CaseIterable {
    case yacht = "Yacht"
    case sailboat = "Sailboat"
    case speedboat = "Speedboat"
    case catamaran = "Catamaran"
    
    var icon: String {
        switch self {
        case .yacht: return "sailboat.fill"
        case .sailboat: return "sailboat"
        case .speedboat: return "car.fill"
        case .catamaran: return "ferry.fill"
        }
    }
}

// Sample data for development
let sampleBoats: [BoatModel] = [
    BoatModel(
        name: "Sea Breeze",
        pricePerHour: 120,
        reviews: 5,
        imageName: "boat1",
        imageURL: "https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400",
        coordinate: CLLocationCoordinate2D(latitude: 41.6422, longitude: 41.6367),
        category: .yacht,
        capacity: 8,
        length: "40ft",
        isAvailable: true,
        ownerName: "Marina Boats",
        description: "Luxury yacht perfect for special occasions"
    ),
    BoatModel(
        name: "Wind Dancer",
        pricePerHour: 85,
        reviews: 4,
        imageName: "boat2",
        imageURL: "https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400",
        coordinate: CLLocationCoordinate2D(latitude: 41.6500, longitude: 41.6400),
        category: .sailboat,
        capacity: 6,
        length: "35ft",
        isAvailable: true,
        ownerName: "Sailing Adventures",
        description: "Perfect sailboat for a peaceful day on the water"
    ),
    BoatModel(
        name: "Speed Demon",
        pricePerHour: 200,
        reviews: 5,
        imageName: "boat3",
        imageURL: "https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=400",
        coordinate: CLLocationCoordinate2D(latitude: 41.6350, longitude: 41.6300),
        category: .speedboat,
        capacity: 4,
        length: "28ft",
        isAvailable: false,
        ownerName: "Fast Boats Co.",
        description: "High-speed boat for thrill seekers"
    )
]
