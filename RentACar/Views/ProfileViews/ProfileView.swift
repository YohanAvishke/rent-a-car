//
//  ProfileView.swift
//  RentACar
//
//  Created by Gavin Li on 1/5/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userManager: UserManager

    @State private var showContactSheet = false
    @State private var showLogoutAlert = false

    var body: some View {
        NavigationView {
            VStack {

                // MARK: - Top: Avatar + Username + Email
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding(.top)

                    Text(userManager.currentUser?.name ?? "Unknown User")
                        .font(.title)
                        .bold()

                    Text(userManager.currentUser?.email ?? "No email")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()

                // MARK: - Options List
                List {

                    NavigationLink(destination: EditProfileView()) {
                        Label("Edit Personal Information", systemImage: "pencil")
                    }

                    NavigationLink(destination: BookingHistoryView()) {
                        Label("Booking History", systemImage: "clock")
                    }

                    NavigationLink(destination: LikedVehiclesView()) {
                        Label("Liked Vehicles", systemImage: "heart")
                    }

                    Button(action: {
                        showContactSheet = true
                    }) {
                        Label("Contact Us", systemImage: "envelope")
                    }
                }
                .listStyle(InsetGroupedListStyle())

                Spacer()

                // MARK: - Logout Button
                Button(action: {
                    showLogoutAlert = true
                }) {
                    Text("Log Out")
                        .foregroundColor(.red)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
                    Button("Log Out", role: .destructive) {
                        userManager.logout()
                    }
                    Button("Cancel", role: .cancel) { }
                }

            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showContactSheet) {
                ContactUsView()
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserManager())
}
