import SwiftUI

struct HomeView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Home Page")
                    .font(.title)
                    .foregroundColor(.white)
                
                // Add your map or content here
                Spacer()
                
                // Example map placeholder
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 300)
                    .overlay(
                        Text("Map View")
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                    .cornerRadius(12)
                    .padding()
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(AuthViewModel())
    }
}
