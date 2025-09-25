import SwiftUI

struct BookingView: View {
    let boat: BoatModel
    @Environment(\.dismiss) private var dismiss
    @State private var numberOfDays = 1 // Use number of days instead of guests
    @State private var paymentMethod = "Card"
    
    private var totalCost: Double {
        return Double(numberOfDays) * boat.pricePerHour * 24 // assuming boat.pricePerHour is per hour
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 24) {
                        // Boat summary
                        HStack {
                            AsyncImage(url: URL(string: boat.imageURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 80, height: 80)
                            }
                            .frame(width: 80, height: 80)
                            .cornerRadius(12)
                            
                            VStack(alignment: .leading) {
                                Text(boat.name)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("$\(Int(boat.pricePerHour))/hour")
                                    .font(.system(size: 16))
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.1))
                        )
                        
                        // Days selector
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Number of Days")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Stepper(value: $numberOfDays, in: 1...30) {
                                Text("\(numberOfDays) day\(numberOfDays > 1 ? "s" : "")")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                        }
                        
                        // Price breakdown
                        VStack(spacing: 12) {
                            HStack {
                                Text("Rental Price")
                                Spacer()
                                Text("$\(String(format: "%.2f", totalCost))")
                            }
                            .foregroundColor(.white)
                            
                            Divider()
                                .background(Color.white.opacity(0.3))
                            
                            HStack {
                                Text("Total")
                                    .font(.system(size: 18, weight: .bold))
                                Spacer()
                                Text("$\(String(format: "%.2f", totalCost))")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.blue)
                            }
                            .foregroundColor(.white)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.1))
                        )
                        
                        // Payment Options
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Choose Payment Method")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Picker("Payment Method", selection: $paymentMethod) {
                                Text("Card").tag("Card")
                                Text("Apple Pay").tag("Apple Pay")
                                Text("Crypto").tag("Crypto")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.1))
                        )
                        
                        // Confirm Button
                        Button("Confirm Booking") {
                            // Implement payment processing based on `paymentMethod`
                            dismiss()
                        }
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(25)
                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding()
                }
            }
            .navigationTitle("Book \(boat.name)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}
