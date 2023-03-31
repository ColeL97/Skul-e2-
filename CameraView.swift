import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject var viewModel = CameraViewModel()
    @State private var capturedImage: UIImage?

    var body: some View {
        ZStack {
            if let image = capturedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No image captured")
                    .font(.title)
                    .foregroundColor(.gray)
            }

            if viewModel.isCameraVisible {
                CameraPreview(session: viewModel.captureSession)
                    .ignoresSafeArea()
            }
        }
        .overlay(
            VStack {
                if viewModel.isCameraVisible {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.capturePhoto { image in
                                capturedImage = image
                            }
                        }) {
                            Image(systemName: "camera")
                                .font(.system(size: 60))
                                .padding()
                                .background(Color.black.opacity(0.5))
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.bottom)
                }
            }
        )
        .onAppear {
            viewModel.toggleCamera()
        }
        .onDisappear {
            viewModel.toggleCamera()
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> UIView {
        let view = UIView()

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
            previewLayer.frame = uiView.bounds
        }
    }
}

class CameraViewModel: NSObject, ObservableObject {
    @Published var isCameraVisible = false
    @Published var isCapturing = false

    let captureSession = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()

    var cameraDevice: AVCaptureDevice?
    var completionHandler: ((UIImage?) -> Void)? // Add this line

    override init() {
        super.init()
        prepareCamera()
    }

   

    func prepareCamera() {
        captureSession.beginConfiguration()

        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            cameraDevice = device
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }

        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }

        captureSession.commitConfiguration()
    }

    func toggleCamera() {
        isCameraVisible.toggle()
        if isCameraVisible {
            captureSession.startRunning()
        } else {
            captureSession.stopRunning()
        }
    }

    func capturePhoto(completion: @escaping (UIImage?) -> Void) {
        isCapturing = true
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
        self.completionHandler = completion // Add this line
    }

    }
extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            completionHandler?(nil)
            return
        }

        if let imageData = photo.fileDataRepresentation(),
           let image = UIImage(data: imageData) {
            DispatchQueue.main.async {
                self.completionHandler?(image)
                self.isCapturing = false
            }
        } else {
            DispatchQueue.main.async {
                self.completionHandler?(nil)
                self.isCapturing = false
            }
        }
    }
}
