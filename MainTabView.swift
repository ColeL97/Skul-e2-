import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }.tag(0)

                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }.tag(1)

                CameraView()
                    .tabItem {
                        Image(systemName: "camera")
                        Text("Camera")
                    }.tag(2)

                TeamView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Team")
                    }.tag(3)

                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }.tag(4)
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}
