import SwiftUI

struct LikedVideosView: View {
    // Add an array of videos or video IDs that the user has liked
    @State private var likedVideos: [String] = ["Video 1", "Video 2", "Video 3"]
    
    var body: some View {
        VStack {
            List(likedVideos, id: \.self) { video in
                // You can create a custom view for each video
                Text(video)
            }
        }
        .navigationTitle("Liked Videos")
    }
}

struct LikedVideosView_Previews: PreviewProvider {
    static var previews: some View {
        LikedVideosView()
    }
}
