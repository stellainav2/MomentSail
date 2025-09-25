import SwiftUI

struct CongratulationsView: View {
    @State private var timer: Timer? = nil
    @State private var timeRemaining = 5

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                    Text("Congratulations")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("You will be redirected to the Home Page in \(timeRemaining) seconds.")
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                }
                .padding()
                .onAppear {
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        timeRemaining -= 1
                        if timeRemaining <= 0 {
                            timer?.invalidate()
                            // Navigate to Home
                        }
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CongratulationsView()
}
