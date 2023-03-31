import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var isLoggedIn: Bool // Add this line
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
    VStack {
        Text("Login")
            .font(.largeTitle)
            .padding(.bottom, 30)

    VStack(alignment: .leading, spacing: 15) {
        Text("Email")
            .font(.headline)
        TextField("Email", text: $email)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)

        Text("Password")
            .font(.headline)
        SecureField("Password", text: $password)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }
    .padding(.horizontal, 30)

        VStack(spacing: 15) {
    Button(action: {
    Task {
        await loginUser()
    }
}) {
    Text("Login")
        .foregroundColor(.white)
        .font(.headline)
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.blue)
        .cornerRadius(8)
}

            Button(action: {
    // Navigate to Sign up screen
            }) {
                Text("Sign up")
        .foregroundColor(.white)
        .font(.headline)
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.green)
        .cornerRadius(8)
}
}
.padding(.horizontal, 30)
            .padding(.top, 30)

        Spacer()
    }
    .padding(.top, 50)
}

    private func loginUser() async {
        async let isLoggedIn = NetworkCall.makeLogin(userName: email, password: password)
        self.isLoggedIn = await isLoggedIn
}
}

struct LoginView_Previews: PreviewProvider {
    @State static private var dummyIsLoggedIn: Bool = false

    static var previews: some View {
        LoginView(isLoggedIn: $dummyIsLoggedIn)
}
}

class NetworkCall {
    static func makeLogin(userName: String, password: String) async -> Bool {
        try? await Task.sleep(nanoseconds: 10000000)
        if userName.lowercased() == "cole@skul.app" && password == "mapleleafs" {
            return true
        } else if userName.lowercased() == "cole@skul.app" && password == "mapleleafs"{
            return true
            } else {
    return false
        }
    }
    
}

