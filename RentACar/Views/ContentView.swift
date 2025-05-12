import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var userManager = UserManager()
    
    var body: some View {
        Group {
            if userManager.isLoggedIn {
                MainTabView()
                    .environmentObject(userManager)
            } else {
                LoginView()
                    .environmentObject(userManager)
            }
        }
        .task {
            userManager.setContext(context)
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            DealerListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}
