import SwiftUI
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegister = false
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Spacer()

                Text("🚗 Welcome!")
                    .font(.largeTitle)
                    .bold()

                Text("Please log in to continue")
                    .font(.headline)
                    .foregroundColor(.secondary)

                // email
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // password
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // login button
                Button(action: {
                    print("Login with email: \(email) and password: \(password)")
                    userManager.login(email: email, password: password)
                }) {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                // Signup button
                Button(action: {
                    showRegister = true
                }) {
                    Text("New User? Sign up here")
                        .foregroundColor(.blue)
                        .padding(.top, 8)
                }
                .sheet(isPresented: $showRegister) {
                    RegisterView()  // jump tp Signup
                }

                Spacer()
            }
            .navigationTitle("Login")
        }
    }
}
