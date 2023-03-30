import SwiftUI

struct ProfileView: View {
    @State private var user: User = User(id: "1", name: "John Doe", email: "john@example.com", bio: "iOS Developer", imageURL: "")
    @State private var editMode = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            if editMode {
                // Show the user's profile picture, and allow them to change it
                Image(uiImage: inputImage ?? UIImage(systemName: "person.circle.fill")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                    .onTapGesture {
                        showingImagePicker = true
                    }
                
                // Other user details (name, email, bio)
                
                Button(action: {
                    if let image = inputImage {
                        FirebaseStorageManager.shared.uploadImage(image: image) { result in
                            switch result {
                            case .success(let url):
                                // Save the image URL to the user object, e.g.
                                user.imageURL = url
                                saveUserDetails()
                                editMode.toggle()
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    } else {
                        saveUserDetails()
                        editMode.toggle()
                    }
                }, label: {
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            } else {
                // Show the user's profile picture and other details
                Image(uiImage: UIImage(systemName: "person.circle.fill")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                
                // Other user details (name, email, bio)
                
                Button(action: {
                    editMode.toggle()
                }, label: {
                    Text("Edit")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
        }
        .padding()
        .navigationTitle("Profile")
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func saveUserDetails() {
        // Save the user details, e.g., update the user data in Firebase
        // Don't forget to save the imageURL too
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        FirebaseStorageManager.shared.uploadImage(image: inputImage) { result in
            switch result {
            case .success(let url):
                // Update the user object with the new image URL
                user.imageURL = url
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
