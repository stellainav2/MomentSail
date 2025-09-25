import SwiftUI

struct BoatDetailsView: View {
    let boat = BoatModel(name: "Yacht Name", pricePerHour: 500, reviews: 4, imageName: "yacht_image")

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    Image(boat.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(boat.name)
                            .font(.title)
                            .foregroundColor(.white)
                        HStack {
                            ForEach(0..<boat.reviews, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                            Text("(\(boat.reviews)) reviews")
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Text("$\(boat.pricePerHour)/hour")
                            .font(.title2)
                            .foregroundColor(.white)
                        Button("Book This Boat") {
                            // Booking logic
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    BoatDetailsView()
}
