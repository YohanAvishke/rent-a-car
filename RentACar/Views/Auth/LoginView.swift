//
//  LoginView.swift
//  RentACar
//
//  Created by Gavin Li on 5/5/2025.
//

import SwiftUI
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegister = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Spacer()

                Text("🚗 Welcome to RentACar")
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
                    // TODO: login logic
                    print("Login with email: \(email) and password: \(password)")
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

#Preview {
    LoginView()
}

