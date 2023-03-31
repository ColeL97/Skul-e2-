import SwiftUI

struct HomeView: View {
    let sampleUser1 = User(id: "1", name: "John Doe", email: "john@example.com", bio: "iOS Developer", imageURL: "https://example.com/profile1.jpg")
    let sampleUser2 = User(id: "2", name: "Jane Smith", email: "jane@example.com", bio: "Graphic Designer", imageURL: "https://example.com/profile2.jpg")

    let sampleComment1 = Comment(id: "1", user: sampleUser2, text: "Great video!")
    let sampleComment2 = Comment(id: "2", user: sampleUser1, text: "Thanks for sharing!")

    let samplePosts: [Post] = [
        Post(id: "1", user: sampleUser1, videoURL: "https://example.com/video1.mp4", description: "My first video!", likes: 10, comments: [sampleComment1]),
        Post(id: "2", user: sampleUser2, videoURL: "https://example.com/video2.mp4", description: "A day in the life!", likes: 25, comments: [sampleComment2])
    ]

    var body: some View {
        NavigationView {
            List(samplePosts) { post in
                PostView(post: post)
            }
            .navigationTitle("Home")
            .listStyle(PlainListStyle())
        }
    }
}
