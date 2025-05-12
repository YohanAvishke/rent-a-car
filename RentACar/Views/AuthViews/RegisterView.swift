import SwiftUI
import SwiftData

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Spacer()

                Text("Create Account")
                    .font(.largeTitle)
                    .bold()

                TextField("Full Name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                Button(action: {
                    print("Registering user: \(name), \(email)")
                    userManager.register(name: name, email: email, phone: phone, password: password)
                    dismiss()
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("Sign Up")
        }
    }
}

#Preview {
    RegisterView()
}
