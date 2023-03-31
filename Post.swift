import Foundation

struct Post: Identifiable {
    let id: String
    let user: User
    let videoURL: String
    let description: String
    let likes: Int
    let comments: [Comment]
}
