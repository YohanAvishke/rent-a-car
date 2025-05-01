//
//  ProfileView.swift
//  RentACar
//
//  Created by Gavin Li on 1/5/2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("👤 Your Profile")
                    .font(.largeTitle)
                    .padding()

                Text("Manage your account details")
                    .font(.title2)
            }
            .navigationTitle("ProfilePage")
        }
    }
}

#Preview {
    ProfileView()
}

