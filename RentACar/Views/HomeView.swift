import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("🏠 Welcome to Home")
                    .font(.largeTitle)
                    .padding()

                Text("Find your perfect rental car!")
                    .font(.title2)
            }
            .navigationTitle("HomePage")
        }
    }
}

#Preview {
    HomeView()
}
