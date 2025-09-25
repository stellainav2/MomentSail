import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var fullName: String
    @State private var email: String
    @State private var city: String
    @State private var country: String

    init() {
        let auth = AuthViewModel() // Default for preview
        _fullName = State(initialValue: auth.profileFullName)
        _email = State(initialValue: auth.profileEmail)
        _city = State(initialValue: auth.profileCity)
        _country = State(initialValue: auth.profileCountry)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("Profile")
                        .font(.title)
                        .foregroundColor(.white)
                    TextField("Full name", text: $fullName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                    TextField("E-mail", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .background(Color.gray.opacity(0.2))
                    HStack {
                        TextField("City", text: $city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                            .foregroundColor(.white)
                            .background(Color.gray.opacity(0.2))
                        TextField("Country/Residence", text: $country)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                            .foregroundColor(.white)
                            .background(Color.gray.opacity(0.2))
                    }
                    HStack {
                        Button("Cancel") {
                            // Revert to original values
                            fullName = auth.profileFullName
                            email = auth.profileEmail
                            city = auth.profileCity
                            country = auth.profileCountry
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        Button("Save") {
                            auth.profileFullName = fullName
                            auth.profileEmail = email
                            auth.profileCity = city
                            auth.profileCountry = country
                            print("Profile saved: \(fullName), \(email), \(city), \(country)")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
