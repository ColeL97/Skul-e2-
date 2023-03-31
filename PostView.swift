import SwiftUI
import AVFoundation

struct PostView: View {
    var post: Post
    @State private var isPlaying = false

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

            if let videoURL = URL(string: post.videoURL) {
                CustomVideoPlayer(url: videoURL, isMuted: true)
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        isPlaying = true
                    }
                    .onDisappear {
                        isPlaying = false
                    }
            } else {
                Text("Video not available")
                    .foregroundColor(.red)
            }

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
