import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var city: String = ""
    @State private var country: String = ""
    @State private var showingImagePicker = false
    @State private var profileImage: Image?
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Image("boat_bg_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.4), Color.black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Profile header
                        VStack(spacing: 16) {
                            Button(action: {
                                showingImagePicker = true
                            }) {
                                ZStack {
                                    if let profileImage = profileImage {
                                        profileImage
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 120, height: 120)
                                            .clipShape(Circle())
                                    } else {
                                        Circle()
                                            .fill(Color.white.opacity(0.2))
                                            .frame(width: 120, height: 120)
                                            .overlay(
                                                Image(systemName: "person.fill")
                                                    .font(.system(size: 50))
                                                    .foregroundColor(.white.opacity(0.7))
                                            )
                                    }
                                    
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                        .frame(width: 120, height: 120)
                                    
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Circle()
                                                .fill(Color.blue)
                                                .frame(width: 35, height: 35)
                                                .overlay(
                                                    Image(systemName: "camera.fill")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 16))
                                                )
                                        }
                                    }
                                    .frame(width: 120, height: 120)
                                }
                            }
                            
                            Text(fullName.isEmpty ? "Your Name" : fullName)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            
                            Text(email.isEmpty ? "your@email.com" : email)
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        // Profile form
                        VStack(spacing: 16) {
                            CustomTextField(title: "Full Name", text: $fullName, icon: "person.fill")
                            CustomTextField(title: "Email", text: $email, icon: "envelope.fill")
                            CustomTextField(title: "City", text: $city, icon: "location.fill")
                            CustomTextField(title: "Country", text: $country, icon: "globe")
                        }
                        
                        // Stats cards
                        HStack(spacing: 16) {
                            StatCard(title: "Bookings", value: "12", icon: "calendar")
                            StatCard(title: "Favorites", value: "8", icon: "heart.fill")
                            StatCard(title: "Reviews", value: "24", icon: "star.fill")
                        }
                        
                        // Action buttons
                        VStack(spacing: 16) {
                            ActionButton(title: "My Bookings", icon: "calendar.badge.clock") {
                                // Navigate to bookings
                            }
                            
                            ActionButton(title: "Favorite Boats", icon: "heart.fill") {
                                // Navigate to favorites
                            }
                            
                            ActionButton(title: "Become a Host", icon: "plus.circle.fill") {
                                // Navigate to host registration
                            }
                            
                            ActionButton(title: "Settings", icon: "gearshape.fill") {
                                // Navigate to settings
                            }
                        }
                        
                        // Save/Cancel buttons
                        HStack(spacing: 16) {
                            Button("Cancel") {
                                // Reset fields
                                fullName = auth.profileFullName
                                email = auth.profileEmail
                                city = auth.profileCity
                                country = auth.profileCountry
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            
                            Button("Save Changes") {
                                // Save profile
                                auth.profileFullName = fullName
                                auth.profileEmail = email
                                auth.profileCity = city
                                auth.profileCountry = country
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(25)
                        }
                        
                        // Sign out button
                        Button("Sign Out") {
                            auth.signOut()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.2))
                        .foregroundColor(.red)
                        .cornerRadius(25)
                        .padding(.top, 20)
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                fullName = auth.profileFullName
                email = auth.profileEmail
                city = auth.profileCity
                country = auth.profileCountry
            }
        }
    }
}

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.6))
                    .frame(width: 20)
                
                TextField(title, text: $text)
                    .foregroundColor(.white)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.blue)
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
        )
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .frame(width: 20)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.6))
                    .font(.system(size: 14))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.1))
            )
        }
    }
}
