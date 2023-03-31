import SwiftUI
import AVFoundation

struct HomeView: View {
    @State var posts: [Post] = []

    var body: some View {
        NavigationView {
            List(posts) { post in
                PostView(post: post)
            }
            .navigationTitle("Home")
            .listStyle(PlainListStyle())
            .onAppear {
                // Initialize sample data
                let sampleUser1 = User(id: "1", name: "John Doe", email: "john@example.com", bio: "iOS Developer", imageURL: "https://example.com/profile1.jpg")
                let sampleUser2 = User(id: "2", name: "Jane Smith", email: "jane@example.com", bio: "Graphic Designer", imageURL: "https://example.com/profile2.jpg")

                let sampleComment1 = Comment(id: "1", user: sampleUser2, text: "Great video!")
                let sampleComment2 = Comment(id: "2", user: sampleUser1, text: "Thanks for sharing!")

                self.posts = [
                    Post(id: "1", user: sampleUser1, videoURL: "https://example.com/video1.mp4", description: "My first video!", likes: 10, comments: [sampleComment1]),
                    Post(id: "2", user: sampleUser2, videoURL: "https://example.com/video2.mp4", description: "A day in the life!", likes: 25, comments: [sampleComment2])
                ]
            }
        }
    }
}

struct VideoPlayer: UIViewRepresentable {
    let url: URL
    let isMuted: Bool

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let player = AVPlayer(url: url)
        player.isMuted = isMuted
        let playerLayer = AVPlayerLayer(player: player)

        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)

        playerLayer.frame = view.bounds
        player.play()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let playerLayer = uiView.layer.sublayers?.first as? AVPlayerLayer {
            playerLayer.frame = uiView.bounds
        }
    }
}
