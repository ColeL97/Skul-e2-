import SwiftUI

struct NotesView: View {
    // Add an array of notes the user has created
    @State private var notes: [String] = ["Note 1", "Note 2", "Note 3"]
    
    var body: some View {
        VStack {
            List(notes, id: \.self) { note in
                // You can create a custom view for each note
                Text(note)
            }
        }
        .navigationTitle("Notes")
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
