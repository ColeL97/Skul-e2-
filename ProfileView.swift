import SwiftUI

struct ProfileView: View {
    @State private var user: User = User(id: "1", name: "John Doe", email: "john@example.com", bio: "iOS Developer", imageURL: "")
    @State private var editMode = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var navigationSelection: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if editMode {
                    // Profile picture
                    Image(uiImage: inputImage ?? UIImage(systemName: "person.circle.fill")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture {
                            showingImagePicker = true
                        }
                    
                    // User name
                    TextField("Name", text: $user.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // Bio
                    TextField("Bio", text: $user.bio)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    // Save button
                    Button(action: {
                        saveUserDetails()
                        editMode.toggle()
                    }, label: {
                        Text("Save")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                } else {
                    // Profile picture
                    Image(uiImage: UIImage(systemName: "person.circle.fill")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .padding()
                    
                    // User name
                    Text(user.name)
                        .font(.title)
                        .padding()
                    
                    // Bio
                    Text(user.bio)
                        .font(.body)
                        .padding()
                    
                    // Edit button
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
                
                // Navigation links
                VStack {
                    Button(action: {
                        navigationSelection = 1
                    }) {
                        Text("Liked Videos")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .background(
                        NavigationLink("", destination: LikedVideosView(), tag: 1, selection: $navigationSelection).opacity(0)
                    )
                    
                    Button(action: {
                        navigationSelection = 2
                    }) {
                        Text("Notes")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .background(
                        NavigationLink("", destination: NotesView(), tag: 2, selection: $navigationSelection).opacity(0)
                    )
                }.padding()
                
            }
            .padding()
            .navigationTitle("Profile")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func saveUserDetails() {
        // Save the user details, e.g., update the user data in Firebase
        // Don't forget
    }
}

