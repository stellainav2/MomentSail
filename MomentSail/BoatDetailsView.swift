import SwiftUI
import MapKit

struct BoatDetailsView: View {
    let boat: BoatModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedImageIndex = 0
    @State private var showBookingSheet = false
    
    private let sampleImages = [
        "https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800",
        "https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800",
        "https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Image carousel
                        TabView(selection: $selectedImageIndex) {
                            ForEach(sampleImages.indices, id: \.self) { index in
                                AsyncImage(url: URL(string: sampleImages[index])) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                }
                                .frame(height: 300)
                                .clipped()
                                .tag(index)
                            }
                        }
                        .frame(height: 300)
                        .tabViewStyle(PageTabViewStyle())
                        
                        // Boat details
                        VStack(alignment: .leading, spacing: 20) {
                            // Header
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(boat.name)
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing) {
                                        Text("$\(Int(boat.pricePerHour))")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(.blue)
                                        Text("per hour")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                }
                                
                                HStack {
                                    ForEach(0..<boat.reviews, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.system(size: 14))
                                    }
                                    Text("(\(boat.reviews)) reviews")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Spacer()
                                    
                                    Text(boat.isAvailable ? "Available" : "Unavailable")
                                        .font(.system(size: 12, weight: .semibold))
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(boat.isAvailable ? Color.green : Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            
                            // Specs
                            HStack(spacing: 20) {
                                SpecView(icon: "person.2.fill", title: "Capacity", value: "\(boat.capacity) people")
                                SpecView(icon: "ruler.fill", title: "Length", value: boat.length)
                                SpecView(icon: "tag.fill", title: "Category", value: boat.category.rawValue)
                            }
                            
                            // Description
                            Text("Description")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Text(boat.description)
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.8))
                                .lineSpacing(4)
                            
                            // Location
                            Text("Location")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            
                            Map(coordinateRegion: .constant(MKCoordinateRegion(
                                center: boat.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                            )), annotationItems: [boat]) { boat in
                                MapPin(coordinate: boat.coordinate, tint: .blue)
                            }
                            .frame(height: 200)
                            .cornerRadius(15)
                            
                            // Owner info
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white.opacity(0.7))
                                
                                VStack(alignment: .leading) {
                                    Text("Hosted by")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white.opacity(0.7))
                                    Text(boat.ownerName)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                Button("Contact") {
                                    // Contact action
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                            }
                            
                            Spacer(minLength: 100) // Space for floating button
                        }
                        .padding(20)
                    }
                }
                
                // Floating book button
                VStack {
                    Spacer()
                    Button(action: {
                        showBookingSheet = true
                    }) {
                        Text("Book This Boat")
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
                    .disabled(!boat.isAvailable)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Favorite action
                    }) {
                        Image(systemName: "heart")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showBookingSheet) {
                BookingView(boat: boat)
            }
        }
    }
}

struct SpecView: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.blue)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.7))
            
            Text(value)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.1))
        )
    }
}

// New BookingView
struct BookingView: View {
    let boat: BoatModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var numberOfGuests = 1
    
    var totalHours: Double {
        endTime.timeIntervalSince(startTime) / 3600
    }
    
    var totalPrice: Double {
        totalHours * boat.pricePerHour
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
                        
                        // Date selection
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Select Date")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(15)
                        }
                        
                        // Time selection
                        HStack(spacing: 16) {
                            VStack(alignment: .leading) {
                                Text("Start Time")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                
                                DatePicker("Start", selection: $startTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(CompactDatePickerStyle())
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(10)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("End Time")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                
                                DatePicker("End", selection: $endTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(CompactDatePickerStyle())
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(10)
                            }
                        }
                        
                        // Guest count
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Number of Guests")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                            
                            HStack {
                                Button("-") {
                                    if numberOfGuests > 1 {
                                        numberOfGuests -= 1
                                    }
                                }
                                .frame(width: 40, height: 40)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                
                                Text("\(numberOfGuests)")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(minWidth: 50)
                                
                                Button("+") {
                                    if numberOfGuests < boat.capacity {
                                        numberOfGuests += 1
                                    }
                                }
                                .frame(width: 40, height: 40)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                
                                Spacer()
                                
                                Text("Max \(boat.capacity)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.1))
                        )
                        
                        // Price breakdown
                        VStack(spacing: 12) {
                            HStack {
                                Text("Duration")
                                Spacer()
                                Text("\(String(format: "%.1f", totalHours)) hours")
                            }
                            .foregroundColor(.white)
                            
                            HStack {
                                Text("Rate")
                                Spacer()
                                Text("$\(Int(boat.pricePerHour))/hour")
                            }
                            .foregroundColor(.white)
                            
                            Divider()
                                .background(Color.white.opacity(0.3))
                            
                            HStack {
                                Text("Total")
                                    .font(.system(size: 18, weight: .bold))
                                Spacer()
                                Text("$\(String(format: "%.2f", totalPrice))")
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
                        
                        // Book button
                        Button("Confirm Booking") {
                            // Process booking
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}
