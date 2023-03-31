import SwiftUI

struct PostView: View {
    var post: Post

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let url = URL(string: post.user.imageURL), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Text(post.user.name)
                    .font(.headline)
                
                Spacer()
            }
            .padding()

            // Add your video player here using the post.videoURL
            // For example, you can use the AVPlayer from AVKit
            
            Text(post.description)
                .padding(.horizontal)

            HStack {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading)

                Text("\(post.likes) likes")
                    .font(.subheadline)

                Spacer()

                Image(systemName: "bubble.right")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing)

                Text("\(post.comments.count) comments")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}
