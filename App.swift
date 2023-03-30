import SwiftUI
import Firebase

@main
struct SkulApp: App {
    @State private var isLoggedIn: Bool = false
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                if isLoggedIn {
                    MainView()
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                }
            }
        }
    }
}

