import SwiftUI
import MapKit
import CoreLocation

struct HomeView: View {
    @EnvironmentObject var auth: AuthViewModel
    @StateObject private var locationManager = LocationManager()
    @State private var boats: [BoatModel] = sampleBoats
    @State private var filteredBoats: [BoatModel] = sampleBoats
    @State private var selectedBoat: BoatModel?
    @State private var showingBoatList = false
    @State private var priceFilter: Double = 500
    @State private var distanceFilter: Double = 50
    
    private func applyFilters() {
        // Implement your filtering logic here based on price and distance
        self.filteredBoats = self.boats.filter { boat in
            // Example filtering logic
            // Check if boat price is within range
            let isPriceMatch = boat.pricePerHour <= priceFilter
            
            // Check if boat is within distance from current location
            // This requires location data, so it's a placeholder
            let isDistanceMatch = true // Placeholder
            
            return isPriceMatch && isDistanceMatch
        }
    }
    
    var body: some View {
        ZStack {
            // Background with map
            Map(coordinateRegion: $locationManager.region,
                showsUserLocation: true,
                annotationItems: filteredBoats) { boat in
                MapAnnotation(coordinate: boat.coordinate) {
                    BoatAnnotationView(boat: boat) {
                        selectedBoat = boat
                    }
                }
            }
            .ignoresSafeArea()
            
            // Top and bottom overlays with glassmorphism
            VStack {
                // ... (existing code for the top overlay with welcome message)
                
                Spacer()
                
                // Bottom control panel with filters
                VStack(spacing: 16) {
                    // Filter sliders
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Filter Options")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text("Max Price: $\(Int(priceFilter))")
                            Spacer()
                            Text("Max Distance: \(Int(distanceFilter)) km")
                        }
                        .foregroundColor(.white.opacity(0.8))
                        
                        Slider(value: $priceFilter, in: 0...1000, step: 10)
                            .tint(.blue)
                        Slider(value: $distanceFilter, in: 0...200, step: 5)
                            .tint(.blue)
                    }
                    .padding()
                    
                    // Search bar and action buttons
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.7))
                        TextField("Search boats near you...", text: .constant(""))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(0.15))
                    )
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            showingBoatList.toggle()
                        }) {
                            HStack {
                                Image(systemName: "list.bullet")
                                Text("List View")
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        }
                        
                        Button(action: {
                            locationManager.requestLocation()
                        }) {
                            HStack {
                                Image(systemName: "location.circle")
                                Text("My Location")
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.black.opacity(0.4))
                        .blur(radius: 0.5)
                )
                .padding()
            }
        }
        .sheet(isPresented: $showingBoatList) {
            BoatListView(boats: filteredBoats)
        }
        .sheet(item: $selectedBoat) { boat in
            BoatDetailsView(boat: boat)
        }
        .onAppear {
            locationManager.requestLocationPermission()
            applyFilters()
        }
        .onChange(of: priceFilter) { _ in applyFilters() }
        .onChange(of: distanceFilter) { _ in applyFilters() }
    }
}
