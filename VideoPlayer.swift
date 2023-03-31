import SwiftUI
import AVFoundation

struct CustomVideoPlayer: UIViewRepresentable {
    var url: URL
    var isMuted: Bool

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let player = AVPlayer(url: url)
        player.isMuted = isMuted

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)

        player.play()

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let playerLayer = uiView.layer.sublayers?.first as? AVPlayerLayer {
            playerLayer.frame = uiView.bounds
        }
    }
}
